#!/bin/bash

set -eux
set -o pipefail
set -o nounset

find . \
  -maxdepth 1 \
  -type f \
  -name "*.sh" \
  -exec shellcheck \
    --exclude=SC1090,SC1091 \
  {} +

shellcheck --exclude=SC1090,SC2148,SC2034,SC2153 .zshrc
