#!/usr/bin/env bash

## Exit if not in fedora
if ! command -v dnf >/dev/null 2>&1; then
  exit 0;
fi

## Enable bottom repository
if ! command -v btm >/dev/null 2>&1; then
  sudo dnf copr enable atim/bottom -y
fi

## Enable onefetch repository
if ! command -v onefetch >/dev/null 2>&1; then
  sudo dnf copr enable varlad/onefetch
fi
