#!/usr/bin/env bash

## Install Atuin
if ! command -v atuin >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
fi

## Install dry
if ! command -v dry >/dev/null 2>&1; then
  curl -sSf https://moncho.github.io/dry/dryup.sh | sudo sh
  sudo chmod 755 /usr/local/bin/dry
fi

## Install NVM
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi

## Install PNPM
if ! command -v pnpm >/dev/null 2>&1; then
  curl -fsSL https://get.pnpm.io/install.sh | sh -
fi

## Install starship
if ! command -v starship >/dev/null 2>&1; then
  curl -sS https://starship.rs/install.sh | sh
fi
