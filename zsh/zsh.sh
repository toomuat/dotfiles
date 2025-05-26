DOTFILES_PATH="${DOTFILES_PATH:-${HOME}/dotfiles}"

if [[ "${OSTYPE}" == "darwin"* ]]; then
  source "${DOTFILES_PATH}"/zsh/mac.sh
elif [[ "$(uname -r)" =~ "microsoft" ]]; then
  source "${DOTFILES_PATH}"/zsh/wsl.sh
fi

source "${DOTFILES_PATH}"/zsh/alias.sh
source "${DOTFILES_PATH}"/zsh/function.sh
source "${DOTFILES_PATH}"/zsh/prompt.sh
source "${DOTFILES_PATH}"/zsh/variable.sh

# Append history to the history file (no overwriting)
setopt appendhistory
# Share history across terminals
setopt sharehistory
# Immediately append to the history file, not just when a term is killed
setopt incappendhistory
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt auto_param_slash
setopt list_types
setopt complete_in_word
setopt no_beep
setopt auto_param_keys
setopt hist_ignore_all_dups

zstyle ':completion:*:default' menu select=2
# Enable case-insensitive completion but distinguish uppercase input
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache true

if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# プラグインのロード（遅延ロード）
zinit wait lucid for \
  zsh-users/zsh-syntax-highlighting \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-completions

zinit snippet https://github.com/rupa/z/blob/master/z.sh

# `binkey -L` to show bindings
bindkey -e
bindkey "^f" forward-char
bindkey "^;" fzf-z-search
bindkey "^o" down-line-or-history
# bindkey "^r" history-incremental-pattern-search-backward
bindkey "^s" history-incremental-pattern-search-forward
bindkey "^X" delete_until_slash
bindkey "^Z" fancy-ctrl-z
# \e[3~: Delete key
bindkey "\e[3~" delete-char

zle -N fancy-ctrl-z
zle -N fzf-z-search
zle -N delete_until_slash

autoload -U compinit
compinit

# bun completions
[ -s "/opt/homebrew/Cellar/bun/0.8.1/share/zsh/site-functions/_bun" ] && source "/opt/homebrew/Cellar/bun/0.8.1/share/zsh/site-functions/_bun"

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

## End of Zinit's installer chunk
