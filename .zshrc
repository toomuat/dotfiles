DOTFILES_PATH="${DOTFILES_PATH:-${HOME}/dotfiles}"

if [[ "${OSTYPE}" == "darwin"* ]]; then
  source "${DOTFILES_PATH}"/.mac.zshrc
elif [[ "$(uname -r)" =~ "microsoft" ]]; then
  source "${DOTFILES_PATH}"/.wsl.zshrc
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
bindkey "^n" fzf-z-search
bindkey "^o" down-line-or-history
bindkey "^r" history-incremental-pattern-search-backward
bindkey "^s" history-incremental-pattern-search-forward
bindkey "^X" delete_until_slash
bindkey "^Z" fancy-ctrl-z
# \e[3~: Delete key
bindkey "\e[3~" delete-char

zle -N fancy-ctrl-z
zle -N fzf-z-search
zle -N delete_until_slash

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh" # This loads nvm
