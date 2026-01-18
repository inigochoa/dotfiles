#!/usr/bin/env bash

## Exit if not in fedora
if ! command -v dnf >/dev/null 2>&1; then
  exit 0;
fi

## Enable lnav repository - https://lnav.org/
if ! command -v lnav >/dev/null 2>&1; then
  curl -s https://packagecloud.io/install/repositories/tstack/lnav/script.rpm.sh | sudo bash
fi
