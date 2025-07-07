# タイミング計測（環境変数 ZSHRC_TIMING=1 で有効化）
if [[ "$ZSHRC_TIMING" == "1" ]]; then
  zmodload zsh/datetime
  _zshrc_start_time=$EPOCHREALTIME
  
  # タイミング計測用関数
  _zshrc_time() {
    local current_time=$EPOCHREALTIME
    local elapsed=$(( current_time - _zshrc_start_time ))
    printf "[%.3fs] %s\n" $elapsed "$1" >&2
  }
else
  # 空の関数（何もしない）
  _zshrc_time() { }
fi

# dotfilesのパスを設定（環境変数がなければデフォルト値）
DOTFILES_PATH="${DOTFILES_PATH:-${HOME}/dotfiles}"
_zshrc_time "DOTFILES_PATH設定完了"

# OSごとに設定ファイルを読み込み
if [[ "${OSTYPE}" == "darwin"* ]]; then
  source "${DOTFILES_PATH}"/zsh/mac.sh
  _zshrc_time "mac.sh読み込み完了"
elif [[ "$(uname -r)" =~ "microsoft" ]]; then
  source "${DOTFILES_PATH}"/zsh/wsl.sh
  _zshrc_time "wsl.sh読み込み完了"
fi

# 各種zsh設定ファイルを読み込み
source "${DOTFILES_PATH}"/zsh/alias.sh
_zshrc_time "alias.sh読み込み完了"
source "${DOTFILES_PATH}"/zsh/function.sh
_zshrc_time "function.sh読み込み完了"
source "${DOTFILES_PATH}"/zsh/prompt.sh
_zshrc_time "prompt.sh読み込み完了"
source "${DOTFILES_PATH}"/zsh/variable.sh
_zshrc_time "variable.sh読み込み完了"

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
# 余分な空白を削除して履歴に保存
setopt hist_reduce_blanks
# インタラクティブシェルで # から始まる行をコメントとして扱う
setopt interactive_comments

# WORDCHARSから'/'と'='を除外（単語区切りの挙動調整）
typeset -g WORDCHARS=${WORDCHARS:s@/@@:s@=@@}

# 補完メニューやキャッシュ、マッチャーの設定
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache true

# 隠しファイル・ディレクトリの補完を有効化
setopt glob_dots

# .zshrcのバイトコード化（zcompile）
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi
_zshrc_time "zshオプション・バイトコード化完了"

# Zinitのインストールと初期化
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "${ZINIT_HOME}" ] && mkdir -p "$(dirname "${ZINIT_HOME}")"
[ ! -d "${ZINIT_HOME}"/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"
source "${ZINIT_HOME}/zinit.zsh"
_zshrc_time "Zinit初期化完了"

# プラグインの遅延ロード
zinit wait lucid for \
  zsh-users/zsh-syntax-highlighting \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-completions \
  Aloxaf/fzf-tab
_zshrc_time "Zinitプラグイン設定完了"

# zコマンドのスニペットをロード
zinit snippet https://github.com/rupa/z/blob/master/z.sh
_zshrc_time "zスニペット読み込み完了"

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

# compinit の最適化：セキュリティチェックをスキップして高速化
autoload -U compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
_zshrc_time "compinit完了"

# bunコマンドの補完スクリプトを読み込み
[ -s "/opt/homebrew/Cellar/bun/0.8.1/share/zsh/site-functions/_bun" ] && source "/opt/homebrew/Cellar/bun/0.8.1/share/zsh/site-functions/_bun"
_zshrc_time "bun補完読み込み完了"

# annexes（Zinit拡張機能）のロード
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
_zshrc_time "Zinit annexes読み込み完了"

## End of Zinit's installer chunk

# fzf-tab の設定
# fzf-tab の設定は compinit の後に記述する必要がある
# fzf のキーバインドは fzf-tab が提供するため、~/.fzf.zsh の読み込みは不要になる
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
_zshrc_time "fzf設定完了"

# 最終タイミング表示とクリーンアップ
if [[ "$ZSHRC_TIMING" == "1" ]]; then
  local total_time=$(( EPOCHREALTIME - _zshrc_start_time ))
  printf "[%.3fs] .zshrc読み込み完了（合計時間）\n" $total_time >&2
  unset _zshrc_start_time
fi
unfunction _zshrc_time
