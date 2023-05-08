(( ${+commands[gdate]} )) && alias date='gdate'
(( ${+commands[gls]} )) && alias ls='gls'
(( ${+commands[gmkdir]} )) && alias mkdir='gmkdir'
(( ${+commands[gcp]} )) && alias cp='gcp'
(( ${+commands[gmv]} )) && alias mv='gmv'
(( ${+commands[grm]} )) && alias rm='grm'
(( ${+commands[gdu]} )) && alias du='gdu'
(( ${+commands[ghead]} )) && alias head='ghead'
(( ${+commands[gtail]} )) && alias tail='gtail'
(( ${+commands[gsed]} )) && alias sed='gsed'
(( ${+commands[ggrep]} )) && alias grep='ggrep'
(( ${+commands[gfind]} )) && alias find='gfind'
(( ${+commands[gdirname]} )) && alias dirname='gdirname'
(( ${+commands[gxargs]} )) && alias xargs='gxargs'

export PATH="/usr/local/sbin:$PATH"
export PATH=$PATH:/opt/homebrew/share/git-core/contrib/diff-highlight

eval "$(/opt/homebrew/bin/brew shellenv)"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
