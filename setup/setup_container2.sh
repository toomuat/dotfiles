#!/bin/zsh

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

source ~/".zshrc"

zplug install
nvm install node # "node" is an alias for the latest version
nvm install-latest-npm
