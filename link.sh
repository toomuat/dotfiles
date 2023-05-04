#!/bin/bash

DOTFILES_PATH="${DOTFILES_PATH:-${HOME}/dotfiles}"

mkdir -p "${HOME}"/.config

ln -snfv "${DOTFILES_PATH}"/.gitconfig "${HOME}"/.gitconfig
ln -snfv "${DOTFILES_PATH}"/.tmux.conf "${HOME}"/.tmux.conf
ln -snfv "${DOTFILES_PATH}"/nvim "${HOME}"/.config/nvim
ln -snfv "${DOTFILES_PATH}"/zsh/zsh.sh "${HOME}"/.zshrc
