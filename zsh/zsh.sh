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

source ~/.zplug/init.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-completions", defer:2
zplug "rupa/z", use:z.sh
zplug load --verbose > /dev/null

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
