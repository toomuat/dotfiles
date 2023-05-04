#!/bin/bash

set -eux
set -o pipefail
set -o nounset

find . \
  -maxdepth 2 \
  -type f \
  -name "*.sh" \
  -exec shellcheck \
    --exclude=SC1071,SC1090,SC1091,SC2034,SC2148,SC2153,SC2155 \
  {} +
