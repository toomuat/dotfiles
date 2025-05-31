#!/bin/bash

ln -snfv "${DOTFILES_PATH}"/Brewfile "${HOME}"/Brewfile
brew bundle

nvm install node

defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
