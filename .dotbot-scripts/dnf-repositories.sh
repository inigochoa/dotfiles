#!/usr/bin/env bash

## Exit if not in fedora
if ! command -v dnf >/dev/null 2>&1; then
  exit 0;
fi

## Enable bottom repository - https://github.com/ClementTsang/bottom
if ! command -v btm >/dev/null 2>&1; then
  sudo dnf copr enable atim/bottom -y
fi

## Enable gping repository - https://github.com/orf/gping
if ! command -v gping >/dev/null 2>&1; then
  sudo dnf copr enable atim/gping -y
fi

## Enable onefetch repository - https://onefetch.dev/
if ! command -v onefetch >/dev/null 2>&1; then
  sudo dnf copr enable varlad/onefetch -y
fi
