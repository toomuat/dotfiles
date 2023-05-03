#!/bin/bash

find . \
  -maxdepth 1 \
  -type f \
  -name "*.sh" \
  -exec shellcheck \
          --exclude=SC1090 \
          --exclude=SC1091 \
          --exclude=SC2155 \
          --exclude=SC2164 \
  {} +
