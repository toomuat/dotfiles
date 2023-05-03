#!/bin/bash

sudo apt update
sudo apt upgrade -y

sudo apt install -y \
  zsh tmux wget cmake build-essential python3 \
  python3-pip unzip

chsh -s "$(command -v zsh)"
sudo chmod +x /usr/share/doc/git/contrib/diff-highlight/diff-highlight
sudo ln -s /usr/share/doc/git/contrib/diff-highlight/diff-highlight \
  /usr/local/bin/diff-highlight

# zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
source ~/".zshrc"
zplug install

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes ~/.fzf/install

# Neovim
# wget https://github.com/neovim/neovim/releases/download/v0.8.2/nvim-linux64.deb && \
#   apt install ./nvim-linux64.deb && \
#   rm ./nvim-linux64.deb
wget https://github.com/neovim/neovim/releases/download/v0.9.0/nvim-linux64.tar.gz && \
  tar xf nvim-linux64.tar.gz && \
  sudo cp nvim-linux64/bin/nvim /usr/local/bin && \
  sudo cp -r nvim-linux64/lib/nvim /usr/local/lib && \
  sudo cp -r nvim-linux64/share/nvim /usr/local/share && \
  rm nvim-linux64.tar.gz
# Packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
# Run PackerIntall in Neovim

# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/".zshrc"
nvm install node # "node" is an alias for the latest version
nvm install-latest-npm

# Docker
sudo apt-get install -y \
  ca-certificates \
  curl \
  gnupg
# Add Docker’s official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
# Use the following command to set up the repository:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(source /etc/os-release < /dev/null && echo "${VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# Install Docker Engine
sudo apt update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin




