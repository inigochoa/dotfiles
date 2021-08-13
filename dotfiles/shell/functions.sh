. ~/.shell/plugins/bash_completion.sh

# Show all the names (CNs and SANs) listed in the SSL certificate of a given domain
certnames() {
  if [ -z "${1}" ]; then
    echo "ERROR: No domain specified."
    return 1
  fi

  local domain="${1}"
  echo "Testing ${domain}…"
  echo

  local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
  | openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1)

  if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
    local certText=$(echo "${tmp}" \
      | openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
      no_serial, no_sigdump, no_signame, no_validity, no_version");

    echo "Common Name:"
    echo

    echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//"
    echo

    echo "Subject Alternative Name(s):"
    echo

    echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
      | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2
  else
    echo "ERROR: Certificate not found.";
  fi;
}

# Throw a dice
dice() {
  r=$(($RANDOM % 6 + 1))

  printf '___________\n|         |\n'

  case $r in
    1) printf '|         |\n|    *    |\n|         |' ;;
    2) printf '|  *      |\n|         |\n|     *   |' ;;
    3) printf '|  *      |\n|    *    |\n|      *  |' ;;
    4) printf '|  *   *  |\n|         |\n|  *   *  |' ;;
    5) printf '|  *   *  |\n|    *    |\n|  *   *  |' ;;
    6) printf '|  * * *  |\n|         |\n|  * * *  |' ;;
  esac

  printf '\n|_________|\n'
}

# devilbox-cli - https://github.com/inigochoa/devilbox-cli
if [ -f ~/.shell/plugins/devilbox-cli/devilbox.sh ]; then
  . ~/.shell/plugins/devilbox-cli/devilbox.sh
fi

# Empty a file
empty() {
  if [ 0 -eq $# ]; then
    echo "empty requires a file as argument"
  else
    cat /dev/null > "$1"
  fi
}

# Compressed file extraction
extract() {
  if [ -z "$1" ]; then
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
  else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
        case "${n%,}" in
          *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
            tar xvf "$n"       ;;
          *.lzma)      unlzma ./"$n"      ;;
          *.bz2)       bunzip2 ./"$n"     ;;
          *.cbr|*.rar)       unrar x -ad ./"$n" ;;
          *.gz)        gunzip ./"$n"      ;;
          *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
          *.z)         uncompress ./"$n"  ;;
          *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
            7z x ./"$n"        ;;
          *.xz)        unxz ./"$n"        ;;
          *.exe)       cabextract ./"$n"  ;;
          *.cpio)      cpio -id < ./"$n"  ;;
          *.cba|*.ace)      unace x ./"$n"      ;;
          *.zpaq)      zpaq x ./"$n"      ;;
          *.arc)         arc e ./"$n"       ;;
          *.cso)       ciso 0 ./"$n" ./"$n.iso" && \
            extract $n.iso && \rm -f $n ;;
          *)
            echo "extract: '$n' - unknown archive method"
            return 1
            ;;
        esac
      else
        echo "'$n' - file does not exist"
        return 1
      fi
    done
  fi
}

# Clone a git repository and cd inside
gclone() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

# Get HTTP code of a site
httpcode() {
  curl  -o /dev/null -sL -w "%{http_code}\n" -I "$1"
}

# Create a directory and cd inside
mkd() {
  mkdir "$@" && cd "$_";
}

# Remove from $PATH
path_remove() {
  PATH=$(echo -n "$PATH" | awk -v RS=: -v ORS=: "\$0 != \"$1\"" | sed 's/:$//')
}

# Append to $PATH
path_append() {
  path_remove "$1"
  PATH="${PATH:+"$PATH:"}$1"
}

# Prepend to $PATH
path_prepend() {
  path_remove "$1"
  PATH="$1${PATH:+":$PATH"}"
}

# Upload file to transfer.sh - https://transfer.sh/
transfer() {
  if [ $# -eq 0 ]; then
    echo -e "No arguments specified.\nUsage:\n  transfer <file|directory>\n  ... | transfer <file_name>">&2

    return 1
  fi

  if tty -s; then
    file="$1"
    file_name=$(basename "$file")

    if [ ! -e "$file" ]; then
      echo "$file: No such file or directory">&2

      return 1
    fi

    if [ -d "$file" ]; then
      file_name="$file_name.zip" ,
      (cd "$file" && zip -r -q - .)|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null,
    else
      cat "$file"|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null
    fi
  else
    file_name=$1
    curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null
  fi

  echo -e "\n"
}

# Weather report
wttr() {
  local request="wttr.in/${1}"
  [ "$(tput cols)" -lt 125 ] && request+='?n'
  curl -H "Accept-Language: ${LANG%_*}" --compressed "$request"
}
