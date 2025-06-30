#!/bin/bash

brew bundle --file="${HOME}"/Brewfile

yes | "$(brew --prefix)"/opt/fzf/install

nvm install node

rustup-init

defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
