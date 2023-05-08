if [[ -d "/mnt/c/Windows" ]]; then
  export PATH=$PATH:/usr/share/doc/git/contrib/diff-highlight

  alias cmd="/mnt/c/Windows/System32/cmd.exe"
  alias exp="/mnt/c/Windows/explorer.exe"
  alias fl="exp ."

  open() {
    /mnt/c/Windows/explorer.exe "$(wslpath -w "$(realpath "$1")")"
  }
fi

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh" # This loads nvm
