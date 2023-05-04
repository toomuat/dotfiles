#!/bin/bash

ln -snfv "${DOTFILES_PATH}"/Brewfile "${HOME}"/Brewfile
brew bundle

