# (( ${+commands[gdate]} )) && alias date='gdate'
# (( ${+commands[gls]} )) && alias ls='gls'
# (( ${+commands[gmkdir]} )) && alias mkdir='gmkdir'
# (( ${+commands[gcp]} )) && alias cp='gcp'
# (( ${+commands[gmv]} )) && alias mv='gmv'
# (( ${+commands[grm]} )) && alias rm='grm'
# (( ${+commands[gdu]} )) && alias du='gdu'
# (( ${+commands[ghead]} )) && alias head='ghead'
# (( ${+commands[gtail]} )) && alias tail='gtail'
# (( ${+commands[gsed]} )) && alias sed='gsed'
# (( ${+commands[ggrep]} )) && alias grep='ggrep'
# (( ${+commands[gfind]} )) && alias find='gfind'
# (( ${+commands[gdirname]} )) && alias dirname='gdirname'
# (( ${+commands[gxargs]} )) && alias xargs='gxargs'

export PATH="/usr/local/sbin:$PATH"
export PATH=$PATH:/opt/homebrew/share/git-core/contrib/diff-highlight
export PATH=$PATH:/opt/homebrew/bin/nvim
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"

alias br="brew"

# Homebrewのパスを直接設定（eval "$(/opt/homebrew/bin/brew shellenv)"の代替）
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}"
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"

# NVMの遅延読み込み
export NVM_DIR="$HOME/.nvm"
# nvmコマンドが実際に呼ばれた時だけ読み込む
nvm() {
    unfunction "$0"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    $0 "$@"
}
