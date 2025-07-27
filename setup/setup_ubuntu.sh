#!/bin/bash

sudo apt update
sudo apt upgrade -y

sudo apt install -y zsh tmux wget cmake build-essential python3 python3-pip unzip stow

chsh -s "$(command -v zsh)"
sudo chmod +x /usr/share/doc/git/contrib/diff-highlight/diff-highlight
sudo ln -s /usr/share/doc/git/contrib/diff-highlight/diff-highlight \
    /usr/local/bin/diff-highlight

# zinit
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install >/dev/null &
yes_pid=$!
wait $yes_pid

# Neovim
LATEST_URL=$(curl -s "https://api.github.com/repos/neovim/neovim/releases/latest" | grep -o 'https://github.com/neovim/neovim/releases/download/.*/nvim-linux-x86_64.tar.gz')
wget "${LATEST_URL}" &&
    tar xf nvim-linux-x86_64.tar.gz &&
    sudo cp nvim-linux-x86_64/bin/nvim /usr/local/bin &&
    sudo cp -r nvim-linux-x86_64/lib/nvim /usr/local/lib &&
    sudo cp -r nvim-linux-x86_64/share/nvim /usr/local/share &&
    rm nvim-linux-x86_64.tar.gz &&
    rm -rf nvim-linux-x86_64

# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
# source ~/".zshrc"
# nvm install node # "node" is an alias for the latest version
# nvm install-latest-npm

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
  $(source /etc/os-release </dev/null && echo "${VERSION_CODENAME}") stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
# Install Docker Engine
sudo apt update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
