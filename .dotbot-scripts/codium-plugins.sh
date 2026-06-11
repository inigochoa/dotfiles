#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTENSIONS_FILE="$PWD/config/codium/extensions-default.txt"

if [[ ! -f "$EXTENSIONS_FILE" ]]; then
  echo "[ERROR] $EXTENSIONS_FILE file not found"
  exit 1
fi

while IFS= read -r ext; do
  [[ -z "$ext" || "$ext" == \#* ]] && continue
  echo "  → $ext"
  codium --install-extension "$ext"
done < "$EXTENSIONS_FILE"
