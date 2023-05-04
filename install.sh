#!/bin/bash

set -eux
set -o pipefail
set -o nounset

DOTFILES_URL=https://github.com/toomuat/dotfiles
DOTFILES_PATH="${DOTFILES_PATH:-${HOME}/dotfiles}"

if [[ "$OSTYPE" == "darwin"* ]]; then
  xcode-select --install
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install git
elif [[ "$(uname -r)" =~ "microsoft" ]] ||
  [[ $(grep -c "Ubuntu" /etc/os-release) -gt 0 ]]; then
  sudo apt update && sudo apt install -y git
else
  echo "OS other than macOS and Ubuntu are not supported."
  exit 1
fi

git clone "${DOTFILES_URL}" "${DOTFILES_PATH}"

/bin/bash "${DOTFILES_PATH}"/link.sh
/bin/bash "${DOTFILES_PATH}"/setup/setup.sh
