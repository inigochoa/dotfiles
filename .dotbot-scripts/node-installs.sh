#!/usr/bin/env bash

## Exit if pnpm is not installed
if ! command -v pnpm >/dev/null 2>&1; then
  exit 0;
fi

readonly PACKAGES=(
  "gitmoji-cli"
)

for package in "${PACKAGES[@]}"; do
  pnpm add -g "$package"
done
