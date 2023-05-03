#!/bin/bash

set -eux
set -o pipefail
set -o nounset

DOTFILES_URL=https://github.com/toomuat/dotfiles
DOTFILES_PATH="${DOTFILES_PATH:-${HOME}/dotfiles}"

git clone "${DOTFILES_URL}" "${DOTFILES_PATH}"

/bin/bash "${DOTFILES_PATH}"/setup.sh
/bin/bash "${DOTFILES_PATH}"/link.sh
