#!/bin/bash

set -eux
set -o pipefail
set -o nounset

find . \
  -type f \
  -name "*.sh" \
  ! -path ".git" \
  ! -path ".github" \
  ! -path "nvim" \
  -exec shellcheck \
    --exclude=SC1071,SC1090,SC1091,SC2034,SC2148,SC2153,SC2155,SC2181\
  {} +

