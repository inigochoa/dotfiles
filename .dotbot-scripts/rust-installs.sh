#!/usr/bin/env bash

# Install rust - <https://rust-lang.org/>
if ! command -v cargo >/dev/null 2>&1; then
  curl https://sh.rustup.rs -sSf | sh -s -- -y
fi

# Install cargo-update
if ! command -v cargo-install-update >/dev/null 2>&1; then
  cargo install --locked cargo-update
fi

# Install cargo packages
readonly PACKAGES=(
  "atuin"
  "bat"
  "bottom"
  "eza"
  "git-cliff"
  "gping"
  "onefetch"
  "procs"
  "starship"
  "tealdeer"
  "tokei"
  "xh"
  "zoxide"
)

for package in "${PACKAGES[@]}"; do
  if ! cargo install --list | grep -q "^${package} v"; then
    cargo install "$package" --locked
  fi
done
