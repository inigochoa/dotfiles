#!/usr/bin/env bash

#
# fnotes - A simple yet powerful note-taking script
# ---------------------------------------------------
# Author: Iñigo Ochoa
# Version: 1.0.0
# License: MIT
#
# Features:
#   - Create and manage markdown notes in a structured directory
#   - Fuzzy search with preview
#   - Content-based search within notes
#   - Daily journal entries
#   - Quick notes from command line or stdin
#

#---------------------------------
# Configuration
#---------------------------------
NAME="fnotes"
CONFIG_FILE="$HOME/.config/$NAME/config"
VERSION="1.0.0"

## ANSI colors for terminal output
BLUE="\033[1;34m"
GREEN="\033[0;32m"
NC="\033[0m"
RED="\033[0;31m"
YELLOW="\033[1;33m"

## Default values
DEFAULT_EDITOR="nano"
DEFAULT_IDE="code"
DEFAULT_DIARY_DIR="diary"
DEFAULT_NOTES_DIR="notes"
DEFAULT_QUICK_DIR="quick"

## Load local configuration if available
if [ -f "$CONFIG_FILE" ]; then
  source "$CONFIG_FILE"
fi

## Final configuration
EDITOR=${EDITOR:-$DEFAULT_EDITOR}
IDE=${IDE:-$DEFAULT_IDE}
DIARY_DIR=${DIARY_DIR:-$DEFAULT_DIARY_DIR}
NOTES_DIR="$HOME/${NOTES_DIR:-$DEFAULT_NOTES_DIR}"
QUICK_DIR=${QUICK_DIR:-$DEFAULT_QUICK_DIR}

#---------------------------------
# Helper Functions
#---------------------------------

# Check that required tools are installed
__fnotes_check_requirements() {
  local missing=0

  for cmd in bat fzf $EDITOR $IDE; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      __fnotes_text_error "'$cmd' is required but not installed."
      missing=1
    fi
  done

  [ "$missing" -eq 1 ] && exit 1
}

# Create a note with given parameters
__fnotes_create() {
  local note="$(__fnotes_slugify "$1")"
  local folder="${2:-}"
  local content="${3:-}"
  local path="$NOTES_DIR/$folder"

  __fnotes_ensure_folder "$path"

  local notepath="$path/$note.md"

  touch "$notepath"
  echo "$content" >> "$notepath"

  "$EDITOR" </dev/tty "$notepath"
}

# Create notes directory if it doesn't exist
__fnotes_ensure_folder() {
  [ ! -d "$1" ] && mkdir -p "$1"
}

# Format large numbers with K, M suffix
__fnotes_format_number() {
  local num=$1

  [ "$num" -ge 1000000000000 ] && {
    echo "$(( num / 1000000000000 ))T"
    return
  }

  [ "$num" -ge 1000000000 ] && {
    echo "$(( num / 1000000000 ))B"
    return
  }

  [ "$num" -ge 1000000 ] && {
    echo "$(( num / 1000000 ))M"
    return
  }

  [ "$num" -ge 1000 ] && {
    echo "$(( num / 1000 ))K"
    return
  }

  echo "$num"
}

# Select a note with fuzzy finding and preview
__fnotes_select() {
  eval "$1" | sed 's|^\./||' | fzf \
    --border-label=" $(__fnotes_cmd_version) " \
    --preview "bat --color=always --style=numbers --line-range=:500 {}" \
    --preview-window "~3"
}

# Convert string to URL-friendly slug
__fnotes_slugify() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g' | sed -E 's/^-+|-+$//g'
}

# Display error text
__fnotes_text_error() {
  echo -e "${RED}[ERR]${NC} $1"
}

# Display warning text
__fnotes_text_warning() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

#---------------------------------
# Main Command Functions
#---------------------------------

# Create or open a diary entry for today
__fnotes_cmd_diary() {
  local note="$(date "+%Y-%m-%d")"
  local content="# $(date "+%H:%M:%S")"

  __fnotes_create "$note" "$DIARY_DIR" "$content"
}

# List and fuzzy-search notes
__fnotes_cmd_edit() {
  local note="${1:-$(__fnotes_select "find . -type f -name '*.md' 2>/dev/null")}"
  [ -n "$note" ] && [ -f "$note" ] && "$EDITOR" "$note"
}

# Display help information
__fnotes_cmd_help() {
  echo -e "${BLUE}$(__fnotes_cmd_version) - A fuzzy note manager script${NC}"
  echo
  echo "Usage: $NAME [command]"
  echo
  echo "Commands:"
  echo "  diary            Create or edit today's diary entry"
  echo "  edit <note>      List notes with preview and edit selection"
  echo "  help             Show this help"
  echo "  new              Create a new note"
  echo "  open             Open notes directory"
  echo "  quick <text>     Create a quick note"
  echo "  search <term>    Search notes by content"
  echo "  version          Show script version"
}

# Create a new note
__fnotes_cmd_new() {
  read -p "Folder path (relative to $NOTES_DIR, empty for root): " folder
  read -p "Note name (empty for timestamp): " note

  __fnotes_create "$note" "$folder"
}

# Open notes directory
__fnotes_cmd_open() {
  "$IDE" "$NOTES_DIR"
}

# Create a quick note from user input
__fnotes_cmd_quick() {
  local content=""
  local param="$1"
  local stdin=""

  [ ! -t 0 ] && stdin=$(command cat -)

  [ -z "$param" ] && [ -z "$stdin" ] && {
    __fnotes_text_error "Please, provide a text for the quick note."
    return
  }

  if [ -n "$param" ] && [ -n "$stdin" ]; then
    content="${param}"$'\n'"${stdin}"
  elif [ -n "$param" ]; then
    content="${param}"
  else
    content="${stdin}"
  fi

  local note="$(date "+%Y-%m-%d_%H-%M-%S")"
  __fnotes_create "$note" "$QUICK_DIR" "$content"
}

# Search within note contents
__fnotes_cmd_search() {
  local query="$1"

  [ -z "$query" ] && {
    __fnotes_text_error "Please, provide a search term."
    return
  }

  local note=$(__fnotes_select "grep -l -r "$query" --include="*.md" .")
  [ -n "$note" ] && "$EDITOR" "$note"
}

# Display notes statistics
__fnotes_cmd_stats() {
  local folders=$(find . -type d | grep -v "^\.$" | wc -l)
  local notes=$(find . -type f -name "*.md" | wc -l)
  local words=$(find . -type f -name "*.md" -exec cat {} \; | wc -w)
  local average=$(( words / notes ))

  printf "┌───────────────────────────────────┐\n"
  printf "│ ${GREEN}$NAME Statistics${NC}                 │\n"
  printf "├───────────────────────────────────┤\n"
  printf "│ Folders:          ${BLUE}%15s${NC} │\n" "$(__fnotes_format_number "$folders")"
  printf "│ Notes count:      ${BLUE}%15s${NC} │\n" "$(__fnotes_format_number "$notes")"
  printf "│ Total words:      ${BLUE}%15s${NC} │\n" "$(__fnotes_format_number "$words")"
  printf "│ Avg words/note:   ${BLUE}%15s${NC} │\n" "$(__fnotes_format_number "$average")"
  printf "└───────────────────────────────────┘"

  echo -e "\n${GREEN}Recent Notes:${NC}"
  find . -type f -name "*.md" -printf "%T@ %TY-%Tm-%Td %p\n" |
    sort -nr |
    head -5 |
    sed 's|./||' |
    awk '{printf "  %s  %s\n", $2, substr($0, length($1)+length($2)+3)}'
}

# Handle unknown commands
__fnotes_cmd_unknown() {
  __fnotes_text_error "Command '$1' not known."
  __fnotes_cmd_help
}

# Display version information
__fnotes_cmd_version() {
  echo "$NAME v$VERSION"
}

#---------------------------------
# Autocomplete Function
#---------------------------------

# Bash autocomplete function for command parameters
__fnotes_autocomplete() {
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  opts="diary edit new open quick search stats help version"

  ## Command autocomplete
  [ $COMP_CWORD -eq 1 ] && {
    COMPREPLY=( $(compgen -W "${opts}" -- "$cur") )
    return 0
  }

  ## Edit command autocomplete
  [[ "${COMP_WORDS[1]}" =~ ^(edit|e)$ ]] && [ $COMP_CWORD -eq 2 ] && {
    local base="$NOTES_DIR"
    [ ! -d "$base" ] && return 0
    COMPREPLY=( $(cd "$base" && compgen -W "$(find . -type f -name '*.md' | sed 's|^\./||')" -- "$cur") )
    return 0
  }
}

#---------------------------------
# Main Function
#---------------------------------

# Primary function that handles all commands
fnotes() {
  __fnotes_check_requirements
  __fnotes_ensure_folder "$NOTES_DIR"

  local command=${1:-edit}
  shift || true

  cd "$NOTES_DIR" || return

  case "$command" in
    ## Main commands
    diary     ) __fnotes_cmd_diary "$@" ;;
    edit      ) __fnotes_cmd_edit "$@" ;;
    new       ) __fnotes_cmd_new "$@" ;;
    open      ) __fnotes_cmd_open "$@" ;;
    quick     ) __fnotes_cmd_quick "$@" ;;
    search    ) __fnotes_cmd_search "$@" ;;
    stats     ) __fnotes_cmd_stats "$@" ;;

    ## Utility commands
    help      ) __fnotes_cmd_help "$@" ;;
    version   ) __fnotes_cmd_version "$@" ;;
    *         ) __fnotes_cmd_unknown "$@" ;;
  esac

  local EXIT_CODE=$?
  cd - &>/dev/null || return
  return $EXIT_CODE
}

complete -F __fnotes_autocomplete fnotes
