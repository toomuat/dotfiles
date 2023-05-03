#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
  bash "${DOTFILES_PATH}"/setup_mac.sh
elif [[ "$(uname -r)" =~ "microsoft" ]] ||
  [[ $(grep -c "Ubuntu" /etc/os-release) -gt 0 ]]; then
  bash "${DOTFILES_PATH}"/setup_ubuntu.sh
elif
  echo "OS other than macOS and Ubuntu are not supported."
fi

