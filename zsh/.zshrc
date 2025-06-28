# dotfilesのパスを設定（環境変数がなければデフォルト値）
DOTFILES_PATH="${DOTFILES_PATH:-${HOME}/dotfiles}"

# OSごとに設定ファイルを読み込み
if [[ "${OSTYPE}" == "darwin"* ]]; then
  source "${DOTFILES_PATH}"/zsh/mac.sh
elif [[ "$(uname -r)" =~ "microsoft" ]]; then
  source "${DOTFILES_PATH}"/zsh/wsl.sh
fi

# 各種zsh設定ファイルを読み込み
source "${DOTFILES_PATH}"/zsh/alias.sh
source "${DOTFILES_PATH}"/zsh/function.sh
source "${DOTFILES_PATH}"/zsh/prompt.sh
source "${DOTFILES_PATH}"/zsh/variable.sh

# ヒストリ関連のzshオプション
# 履歴を追記・共有・即時反映など
setopt appendhistory
setopt sharehistory
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

# WORDCHARSから'/'と'='を除外（単語区切りの挙動調整）
typeset -g WORDCHARS=${WORDCHARS:s@/@@:s@=@@}

# 補完メニューやキャッシュ、マッチャーの設定
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache true

# .zshrcのバイトコード化（zcompile）
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

# Zinitのインストールと初期化
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "${ZINIT_HOME}" ] && mkdir -p "$(dirname "${ZINIT_HOME}")"
[ ! -d "${ZINIT_HOME}"/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"
source "${ZINIT_HOME}/zinit.zsh"

# プラグインの遅延ロード
zinit wait lucid for \
  zsh-users/zsh-syntax-highlighting \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-completions

# zコマンドのスニペットをロード
zinit snippet https://github.com/rupa/z/blob/master/z.sh

# キーバインド設定
# `binkey -L` で一覧表示可能
bindkey -e
bindkey "^f" forward-char
bindkey "^;" fzf-z-search
bindkey "^o" down-line-or-history
# bindkey "^r" history-incremental-pattern-search-backward
bindkey "^s" history-incremental-pattern-search-forward
bindkey "^Z" fancy-ctrl-z
bindkey "\e[3~" delete-char

# zleウィジェット登録
zle -N fancy-ctrl-z
zle -N fzf-z-search

autoload -U compinit
compinit

# bunコマンドの補完スクリプトを読み込み
[ -s "/opt/homebrew/Cellar/bun/0.8.1/share/zsh/site-functions/_bun" ] && source "/opt/homebrew/Cellar/bun/0.8.1/share/zsh/site-functions/_bun"

# annexes（Zinit拡張機能）のロード
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

## End of Zinit's installer chunk
