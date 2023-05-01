if [[ -d "/mnt/c/Windows" ]]; then
  alias cmd="/mnt/c/Windows/System32/cmd.exe"
  alias exp="/mnt/c/Windows/explorer.exe"
  alias fl="exp ."

  open() {
    /mnt/c/Windows/explorer.exe "$(wslpath -w "$(realpath "$1")")"
  }
fi
