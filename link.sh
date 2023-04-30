#!/bin/bash

DOTFILES_PATH="${DOTFILES_PATH:-${HOME}/dotfiles}"

ln -snfv "${DOTFILES_PATH}"/.gitconfig "${HOME}"/.gitconfig
ln -snfv "${DOTFILES_PATH}"/.tmux.conf "${HOME}"/.tmux.conf
ln -snfv "${DOTFILES_PATH}"/nvim "${HOME}"/.config/nvim
ln -snfv "${DOTFILES_PATH}"/.zshrc "${HOME}"/.zshrc
