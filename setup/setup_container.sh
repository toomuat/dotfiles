#!/bin/bash

set -eux
set -o pipefail
set -o nounset

TZ=Asia/Tokyo
ln -snf /usr/share/zoneinfo/"${TZ}" /etc/localtime
echo "${TZ}" > /etc/timezone
sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' \
  /etc/apt/sources.list

apt update
apt upgrade -y

apt install -y \
  git zsh tmux wget cmake build-essential python3 \
  python3-pip unzip

chsh -s "$(command -v zsh)"
# chmod +x /usr/share/doc/git/contrib/diff-highlight/diff-highlight
# ln -s /usr/share/doc/git/contrib/diff-highlight/diff-highlight \
#   /usr/local/bin/diff-highlight
python3 -m pip install diff-highlight --break-system-packages

DOTFILES_URL=https://github.com/toomuat/dotfiles
DOTFILES_PATH="${DOTFILES_PATH:-${HOME}/dotfiles}"

git clone "${DOTFILES_URL}" "${DOTFILES_PATH}"
/bin/bash "${DOTFILES_PATH}"/link.sh

# zplug
set +e
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
# source ~/".zshrc"
# zplug install

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install > /dev/null
set -e

# Neovim
# wget https://github.com/neovim/neovim/releases/download/v0.8.2/nvim-linux64.deb && \
#   apt install ./nvim-linux64.deb && \
#   rm ./nvim-linux64.deb
wget https://github.com/neovim/neovim/releases/download/v0.9.0/nvim-linux64.tar.gz && \
  tar xf nvim-linux64.tar.gz && \
  cp nvim-linux64/bin/nvim /usr/local/bin && \
  cp -r nvim-linux64/lib/nvim /usr/local/lib && \
  cp -r nvim-linux64/share/nvim /usr/local/share && \
  rm nvim-linux64.tar.gz
# Packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
# Run :PackerInstall in Neovim

# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
# source ~/".zshrc"
# nvm install node # "node" is an alias for the latest version
# nvm install-latest-npm

