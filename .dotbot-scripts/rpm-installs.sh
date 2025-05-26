#!/usr/bin/env bash

## Install timer - https://github.com/caarlos0/timer
if ! command -v timer >/dev/null 2>&1; then
  curl -L https://github.com/caarlos0/timer/releases/download/v1.4.6/timer-1.4.6-1.x86_64.rpm -o timer.rpm && sudo dnf install -y timer.rpm && rm timer.rpm
fi
