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

# setopt で設定できるオプションは `man zshoptions`で確認できる
#
# ヒストリ関連のzshオプション
# 履歴を追記・共有・即時反映など
# コマンド履歴をセッション終了時に既存の履歴ファイルに追加する
setopt appendhistory
# 複数のZshセッション間で履歴を共有する
setopt sharehistory
# コマンド実行後すぐに履歴ファイルに書き込む（履歴の即時共有を可能にする）
setopt incappendhistory
# ディレクトリ名のみを入力した場合に自動的にそのディレクトリへ移動する
setopt auto_cd
# cdコマンドでディレクトリを移動した際に、自動的にディレクトリスタックにプッシュする
setopt auto_pushd
# ディレクトリスタックに重複するエントリを追加しない
setopt pushd_ignore_dups
# コマンドラインで引数として指定されたディレクトリの末尾に自動的にスラッシュを追加する
setopt auto_param_slash
# 補完候補を表示する際に、ファイルの種類（ディレクトリ、実行可能ファイルなど）を示す記号を表示する
setopt list_types
# 単語の途中でも補完を可能にする（例: `doc` と入力して `documents` を補完）
setopt complete_in_word
# エラーや補完候補がない場合にビープ音を鳴らさない
setopt no_beep
# コマンドラインの引数として指定されたファイル名やディレクトリ名に対して、自動的にワイルドカード展開を行う
# このオプションは `auto_param_keys` ではなく `auto_param_keys` は存在しないか、非常に古いZshのバージョンにのみ存在する可能性があります。
# 一般的には `auto_param_slash` や `auto_name_dirs` などが関連します。もし意図が異なる場合はご確認ください。
setopt auto_param_keys
# 履歴から重複するコマンドを削除する（連続する重複だけでなく、履歴全体から）
setopt hist_ignore_all_dups
# プロンプト文字列内で変数展開やコマンド置換を可能にする
setopt prompt_subst
# コマンドのスペルミスを自動的に修正する
setopt correct
# コマンドと引数の両方のスペルミスを自動的に修正する
setopt correct_all
# グロブ展開で拡張パターンマッチングを有効にする
setopt extended_glob
# スペースで始まるコマンドを履歴に保存しない
setopt hist_ignore_space
# インタラクティブシェルで # から始まる行をコメントとして扱う
setopt interactive_comments

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
# Emacs風のキーバインドモードを設定
bindkey -e
# Ctrl-f でカーソルを1文字分前に移動
bindkey "^f" forward-char
# Ctrl-; でfzf-z-searchウィジェットを実行
# (zコマンド履歴からfzfでディレクトリ検索)
bindkey "^;" fzf-z-search
# Ctrl-o で複数行のコマンド入力時に次の行に移動、
# または履歴の次のエントリに移動
bindkey "^o" down-line-or-history
# Ctrl-r で履歴をインクリメンタルに逆方向検索
# bindkey "^r" history-incremental-pattern-search-backward
# Ctrl-s で履歴をインクリメンタルに順方向検索
bindkey "^s" history-incremental-pattern-search-forward
# Ctrl-Z でfancy-ctrl-zウィジェットを実行
# (フォアグラウンドに戻すか、入力を一時保存して画面クリア)
bindkey "^Z" fancy-ctrl-z
# Deleteキーでカーソル位置の文字を削除
bindkey "\e[3~" delete-char

# 入力中の文字列で履歴をフィルタリングして遡る
bindkey "^[[A" history-search-backward # 上矢印キー
bindkey "^[[B" history-search-forward # 下矢印キー

# zle(Zsh Line Editor) ウィジェット登録
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
