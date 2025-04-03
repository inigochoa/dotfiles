#!/usr/bin/env bash

## Install Atuin - https://atuin.sh/
if ! command -v atuin >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
fi

## Install ctop - https://github.com/bcicen/ctop
if ! command -v ctop >/dev/null 2>&1; then
  sudo wget https://github.com/bcicen/ctop/releases/download/v0.7.7/ctop-0.7.7-linux-amd64 -O /usr/local/bin/ctop
  sudo chmod +x /usr/local/bin/ctop
fi

## Install dry - https://moncho.github.io/dry/
if ! command -v dry >/dev/null 2>&1; then
  curl -sSf https://moncho.github.io/dry/dryup.sh | sudo sh
  sudo chmod 755 /usr/local/bin/dry
fi

## Install NVM - https://github.com/nvm-sh/nvm
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi

## Install PNPM - https://pnpm.io/
if ! command -v pnpm >/dev/null 2>&1; then
  curl -fsSL https://get.pnpm.io/install.sh | sh -
fi

## Install starship - https://starship.rs/
if ! command -v starship >/dev/null 2>&1; then
  curl -sS https://starship.rs/install.sh | sh
fi

## Install xh - https://github.com/ducaale/xh
if ! command -v xh >/dev/null 2>&1; then
  curl -sfL https://raw.githubusercontent.com/ducaale/xh/master/install.sh | sh
fi
