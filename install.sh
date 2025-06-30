#!/bin/bash

set -eux
set -o pipefail
set -o nounset

DOTFILES_URL=https://github.com/toomuat/dotfiles
DOTFILES_PATH="${DOTFILES_PATH:-${HOME}/dotfiles}"

# OS detection
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS. Starting setup..."
    if ! xcode-select -p &>/dev/null; then
        xcode-select --install
    fi
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install git

    git clone "${DOTFILES_URL}" "${DOTFILES_PATH}"

    mkdir -p "${HOME}"/.config
    cd "${DOTFILES_PATH}"
    stow git nvim tmux zsh wezterm brew
    cd -

    /bin/bash "${DOTFILES_PATH}"/setup/setup_mac.sh

elif [[ "$(uname -r)" =~ "microsoft" ]] || [[ $(grep -c "Ubuntu" /etc/os-release) -gt 0 ]]; then
    echo "Detected Ubuntu/WSL. Starting setup..."
    sudo apt update && sudo apt install -y git

    git clone "${DOTFILES_URL}" "${DOTFILES_PATH}"

    mkdir -p "${HOME}"/.config
    cd "${DOTFILES_PATH}"
    stow git nvim tmux zsh wezterm
    cd -

    /bin/bash "${DOTFILES_PATH}"/setup/setup_ubuntu.sh

else
    echo "OS other than macOS and Ubuntu are not supported."
    exit 1
fi

echo "Dotfiles setup complete!"
