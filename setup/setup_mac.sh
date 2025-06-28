#!/bin/bash

brew bundle

yes | "$(brew --prefix)"/opt/fzf/install

nvm install node

defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
