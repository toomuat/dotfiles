#!/bin/bash

xcode-select --install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

ln -snfv "${DOTFILES_PATH}"/Brewfile "${HOME}"/Brewfile
brew bundle

