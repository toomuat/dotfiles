# 指定したディレクトリに移動し、lsで中身を表示
cdls() {
    if [[ -d "$1" ]]; then
        cd "$1" || return
        ls
    else
        echo "$1 is not a valid directory"
    fi
}

# ディレクトリがなければ作成して移動
mcd() {
    if [[ ! -d "$1" ]]; then
        mkdir -p "$1"
        cd "$1" || return
    fi
}

# ディレクトリを.bakとしてバックアップ
backup() {
    if [[ -d "$1" ]]; then
        cp "$1"{,.bak}
    fi
}

# ルートからファイル名をあいまい検索
gfind() {
    find / -iname "$@" 2>/dev/null
}

# カレントディレクトリ以下をあいまい検索
lfind() {
    find . -iname "$@" 2>/dev/null
}

# manで検索し、なければブラウザでGoogle検索
search() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: search <word>"
        return 1
    fi

    man "$1" 2>/dev/null || "${BROWSER}" "http://www.google.com/search?q=\"$1\""
}

# CSVファイルをSQLでクエリ実行
sqlcsv() {
    if [ $# -lt 2 ]; then
        echo "Usage: sqlcsv [filename.csv] [SQL]"
        echo "In the SQL, refer to the data sourse as [filename]"
    else
        filename="$1"
        if [ ! -f "${filename}" ]; then
            echo "${filename} not found"
            return 1
        fi

        dataname=${filename%????}
        sql_query="$2"
        sqlite3 :memory: -cmd ".mode csv" \
            -cmd ".import ${filename} ${dataname}" \
            -cmd "${sql_query}"
    fi
}

# 指定した列だけ抽出
col() {
    var_column="$1"
    # shellcheck disable=SC2027,SC2086
    awk "{print "${var_column}"}"
    # awk -v col="$1" "{print ${col}}"
}

# curlで取得したスクリプトを一度エディタで開いてから実行
curlsh() {
    local file

    file=$(mktemp -t curlshXXXX) || {
        echo "Failed creating file"
        return
    }
    curl -s "$1" >"${file}" || {
        echo "Failed to curl file"
        return
    }
    "${EDITOR}" "${file}" || {
        echo "Editor quit with error code"
        return
    }
    sh "${file}"
    rm "${file}"
}

# Rustファイルをコンパイルして実行
rc() {
    local filepath="$1"
    local extension="${filepath##*.}"
    if [[ ! "${extension}" == "rs" ]]; then
        return 1
    fi

    local name

    name=$(basename "$1" .rs)
    rustc "${filepath}"
    ./"${name}"
    rm "${name}"
}

# LaTeX + BibTeX + PDF化
bib() {
    platex "$1"
    pbibtex "$(basename "$1" .tex)"
    platex "$1"
    platex "$1"
    #platex "$1"
    dvipdfmx "$(basename "$1" .tex)"
}

# https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
fancy-ctrl-z() {
    if [[ $(($#BUFFER)) -eq 0 ]]; then
        BUFFER="fg"
        zle accept-line
    else
        zle push-input
        zle clear-screen
    fi
}

RED="\e[1;32m"
RED_BOLD="\e[1;4;31m"
YELLOW="\e[01;33m"
RESET="\e[0m"

# manページの色付け
man() {
    env \
        LESS_TERMCAP_mb="$(printf "\e[1;32m")" \
        LESS_TERMCAP_md="$(printf "\e[1;32m")" \
        LESS_TERMCAP_me="$(printf "\e[0m")" \
        LESS_TERMCAP_se="$(printf "\e[0m")" \
        LESS_TERMCAP_so="$(printf "\e[01;33m")" \
        LESS_TERMCAP_ue="$(printf "\e[0m")" \
        LESS_TERMCAP_us="$(printf "\e[1;4;31m")" \
        man "$@"
}

# 1つ前のコミットにcheckout
gn() {
    git log --all --reverse --pretty=%H |
        grep -A1 "$(git rev-parse HEAD)" |
        tail -1 |
        xargs git checkout
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND="fd --type file --hidden --follow --exclude .git --color=always"
# fzfのデフォルトオプション
# --height: 高さを90%に設定
# --reverse: 結果を上から下に表示
# --border: ボーダーを表示
# --ansi: ANSIカラーコードを有効化
# --no-preview: デフォルトではプレビューを無効
# キーバインド:
#   alt-p/alt-n: プレビューの上下スクロール
#   ctrl-u/ctrl-d: プレビューのページアップ/ダウン
#   ctrl-y/ctrl-e: プレビューの行単位スクロール
export FZF_DEFAULT_OPTS="--height 90% --reverse --border --ansi --no-preview --bind alt-p:preview-up,alt-n:preview-down,ctrl-u:preview-page-up,ctrl-d:preview-page-down,ctrl-y:preview-up,ctrl-e:preview-down"
# fzfのAlt+C（ディレクトリ変更）専用オプション
# Alt+Cを押すとサブディレクトリ一覧が表示され、選択したディレクトリに移動
# --reverse: 結果を上から下に表示
# --preview: ディレクトリの中身をtreeコマンドで表示（カラー付き、200行まで）
export FZF_ALT_C_OPTS="--reverse --preview 'tree -C {} | head -200'"
# fzfのCtrl+R（履歴検索）専用オプション
# --preview: 選択中のコマンドをecho表示
# --preview-window: プレビューを下部3行に表示、初期状態では非表示
# --bind: ?キーでプレビューの表示/非表示を切り替え
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# fzfでブランチ選択してcheckout
fbr() {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
        branch=$(echo "${branches}" |
            fzf-tmux -d $((2 + $(wc -l <<<"${branches}"))) +m) &&
        git checkout "$(echo "${branch}" | sed 's/.* //' | sed 's#remotes/[^/]*/##')"
}

# zコマンドの履歴からディレクトリ移動
fzf-z-search() {
    local res

    res=$(z | sort -rn | cut -c 12- | fzf)
    if [ -n "$res" ]; then
        BUFFER+="cd $res"
        zle accept-line
    else
        return 1
    fi
}

# https://zenn.dev/k4zu/scraps/58907ad402b02c
# fzfでファイル選択してbatで中身表示
fcat() {
    local selected

    if [ $# = 0 ]; then
        selected=$(fd --color=always -t f | fzf --preview 'bat --color=always {}')
    else
        if [ -f "$0" ]; then
            selected=$1
        else
            selected=$(fd --color=always -t f |
                fzf --query "$0")
        fi
    fi

    if [ -n "${selected}" ]; then
        print -s "bat ${selected}"
        bat "${selected}"
    else
        # echo "No file is selected"
        false
    fi
}

# https://stackoverflow.com/questions/65366464/is-there-a-way-to-cancel-fzf-by-pressing-escape
# fzfでファイルのプレビューを表示してnvimでファイルを開く
vf() {
    local file_name

    file_name=$(fzf --preview 'bat --color=always {}') || return
    nvim "${file_name}"
}

# fzfでディレクトリ選択してcd
fcd() {
    local dir_name

    dir_name=$(fd --type d | fzf) || return
    cd "${dir_name}" || return
}

# 任意コミットのファイルをfzfで選択して中身表示
fgf() {
    # Gitリポジトリ内にいるかチェック
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "Not in a git repository."
        return
    fi

    local reply commit_id file_lists file

    # Step 1: コミットを選択
    fzf_result=$(
        git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
            fzf --no-sort --tiebreak=index \
                --bind=ctrl-s:toggle-sort \
                --expect=enter,ctrl-c,esc \
                --preview-window=right:60%:wrap \
                --preview "git show --color=always \$(echo {} | grep -o \"[a-f0-9]\\{7\\}\")"
    )

    reply=$(echo "${fzf_result}" | head -1)
    commit_id=$(echo "${fzf_result}" | tail -1 | grep -o "[a-f0-9]\\{7\\}")
    [[ -z "${commit_id}" ]] && return

    case "${reply}" in
    enter) ;;
    ctrl-c) return ;;
    esc) return ;;
    *) ;;
    esac

    # Step 2: そのコミットのファイルを選択
    file_lists=$(git ls-tree -r --name-only "${commit_id}")
    if [[ -z "${file_lists}" ]]; then
        echo "No files found in commit ${commit_id}"
        return
    fi

    fzf_result=$(
        echo "${file_lists}" |
            fzf --no-sort --tiebreak=index \
                --bind=ctrl-s:toggle-sort \
                --expect=enter,ctrl-c,esc \
                --preview-window=right:60%:wrap \
                --preview "git show --color=always ${commit_id}:{}"
    )

    reply=$(echo "${fzf_result}" | head -1)
    file=$(echo "${fzf_result}" | tail -1)

    case "${reply}" in
    enter) ;;
    ctrl-c) return ;;
    esc)
        fgf "$@"
        return
        ;;
    *) return ;;
    esac

    if [[ -n "${file}" ]]; then
        echo "Showing ${commit_id}:${file}"
        git show "${commit_id}":"${file}"
    fi
}

# fzfでカレントディレクトリのファイルをプレビュー
fpre() {
    while true; do
        local file
        file=$(fd --type f --hidden --follow --exclude .git | fzf --preview 'bat --color=always {}' --expect=esc,enter)

        local key=$(echo "$file" | head -1)
        local selected_file=$(echo "$file" | tail -1)

        case "$key" in
        "enter")
            if [[ -n "$selected_file" ]]; then
                bat "$selected_file"
                echo "Press any key to return to fzf..."
                read -r
            fi
            ;;
        "esc" | "")
            break
            ;;
        esac
    done
}

# GitHub Actions workflowを実行
gh-run() {
    if [[ $# != 1 ]]; then
        echo "Usage: gh-run <workflow>"
        return 1
    fi

    workflow="$1"
    gh workflow run .github/workflows/"${workflow}" --ref "$(git branch --show-current)"
}

# GitHub Actions workflowの最新実行をwatch
gh-watch() {
    if [[ $# != 1 ]]; then
        echo "Usage: gh-watch <workflow>"
        return 1
    fi

    workflow="$1"
    gh run list --workflow="${workflow}" |
        grep "$(git branch --show-current)" |
        cut -f 7 |
        head -n 1 |
        xargs gh run watch
}

# GitHub Actions workflowの最新実行をview
gh-view() {
    if [[ $# != 1 ]]; then
        echo "Usage: gh-view <workflow>"
        return 1
    fi

    workflow="$1"
    gh run list --workflow="${workflow}" |
        grep "$(git branch --show-current)" |
        cut -f 7 |
        head -n 1 |
        xargs gh run view
}

# GitHub Actions workflowのログを表示
gh-log() {
    if [[ $# != 1 ]]; then
        echo "Usage: gh-log <workflow>"
        return 1
    fi

    workflow="$1"
    gh run list --workflow="${workflow}" |
        grep "$(git branch --show-current)" |
        cut -f 7 |
        head -n 1 |
        xargs gh run view --log
}

# fzfでGitHubリポジトリを選択してwebで開く
ghv() {
    local repo

    repo=$(gh repo list "$1" --json nameWithOwner -q '.[].nameWithOwner' | fzf)

    if [[ -z "${repo}" ]]; then
        return
    fi

    gh repo view --web "${repo}"
}

# fzfでPRを選択してcheckout
ghp() {
    echo "PRを選択するとそのブランチにcheckoutされます"
    selected_pr=$(gh pr list --limit 100 | fzf --preview "gh pr view \$(echo {} | cut -f1) --json body --template \"{{.body}}\"")
    pr_number=$(echo "${selected_pr}" | awk '{print $1}')
    if [ -n "${pr_number}" ]; then
        gh co "${pr_number}"
    else
        echo "PRが選択されませんでした"
    fi
}

# fzfでPRを選択してwebで表示
ghpv() {
    echo "PRを選択するとwebで表示されます"
    selected_pr=$(gh pr list --limit 100 | fzf --preview "gh pr view \$(echo {} | cut -f1) --json body --template \"{{.body}}\"")
    pr_number=$(echo "${selected_pr}" | awk '{print $1}')
    if [ -n "${pr_number}" ]; then
        gh pr view -w "${pr_number}"
    else
        echo "PRが選択されませんでした"
    fi
}

# Copilot CLIのラッパー
ghco() {
    gh copilot suggest -t shell "$@"
}

# tmuxの画面を分割する関数
tmux_split_layout() {
    # まず左右に分割 (左3:右7の比率)
    tmux split-window -h -p 70

    # 左側のペイン（ペイン1）を選択して4分割 (均等に)
    tmux select-pane -t 1
    tmux split-window -v -p 75
    tmux select-pane -t 2
    tmux split-window -v -p 66
    tmux select-pane -t 3
    tmux split-window -v -p 50

    # 右側のペイン（ペイン5）を選択して上下に分割
    tmux select-pane -t 5
    tmux split-window -v -p 25

    # 右下のペインを左右に分割
    tmux select-pane -t 6
    tmux split-window -h

    # 最初のペインを選択してアタッチ
    tmux select-pane -t 1
}

# fzfを使ってプロセスを検索し、killする
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m -q "$1" --preview 'ps -fp {}' | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m -q "$1" | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]; then
        echo "$pid" | xargs kill -"${2:-9}"
    fi
}

# ghqで管理されているリポジトリをfzfで選択してcd
ghqcd() {
    local selected_repo
    selected_repo=$(ghq list | fzf)
    if [ -n "${selected_repo}" ]; then
        cd "$(ghq root)/${selected_repo}" || return
    fi
}

# fzfで関数をコメント付きで検索し、選択した関数名をクリップボードにコピーする
ffunc-preview() {
    # 検索対象のファイルを列挙する
    # 他にも関数を定義しているファイルがあればここに追加してください
    local zsh_files=(
        "~/dotfiles/zsh/function.sh"
        "~/dotfiles/zsh/alias.sh"
        "~/dotfiles/zsh/.zshrc"
    )

    # チルダを展開した絶対パスに変換
    local expanded_files=()
    for file in "${zsh_files[@]}"; do
        expanded_files+=("$(eval echo "$file")")
    done

    # awkスクリプトでコメントと関数を抽出し、fzfに渡す
    local selected_func
    selected_func=$(awk '
        # 関数定義のパターンに一致した場合 (例: my_func() { )
        /^[a-zA-Z0-9_-]+[[:space:]]*\([[:space:]]*\)[[:space:]]*\{?$/ {
            # 関数名だけを抽出する
            func_name = $0
            sub(/[[:space:]]*\([[:space:]]*\)[[:space:]]*\{?$/, "", func_name)

            # それまでに溜めたコメントがあれば、それも一緒に出力
            if (comment_buffer) {
                # コメントの先頭の # とスペースを削除して整形
                gsub(/^[[:space:]]*#[[:space:]]*/, "", comment_buffer)
                printf "%-5s --- %s\n", func_name, comment_buffer
            } else {
                printf "%-5s\n", func_name
            }
            # バッファをリセット
            comment_buffer = ""
            next
        }
        # コメント行のパターンに一致した場合
        /^[[:space:]]*#/ {
            # コメントをバッファに溜める
            if (comment_buffer) {
                comment_buffer = comment_buffer " " $0
            } else {
                comment_buffer = $0
            }
            next
        }
        # コメントでも関数定義でもない行が来たらバッファをリセット
        { comment_buffer = "" }
    ' "${expanded_files[@]}" | fzf --preview '
        func_name=$(echo {} | awk "{print \$1}")
        if [[ -n "$func_name" ]]; then
            for file in '"$(printf '"%s" ' "${expanded_files[@]}")"'; do
                if [[ -f "$file" ]]; then
                    line_num=$(grep -n "^${func_name}[[:space:]]*(" "$file" | head -1 | cut -d: -f1)
                    if [[ -n "$line_num" ]]; then
                        echo "=== Function: $func_name in $file ==="
                        sed -n "${line_num},$((line_num + 15))p" "$file"
                        break
                    fi
                fi
            done
        fi
    ' --preview-window=right:60%:wrap --bind '?:toggle-preview')

    # fzfで何かが選択された場合
    if [[ -n "$selected_func" ]]; then
        # "---" の前にある関数名部分だけを切り出してコピー
        local func_to_copy
        func_to_copy=$(echo "$selected_func" | awk '{print $1}')
        echo -n "$func_to_copy" | pbcopy
        echo "Copied '$func_to_copy' to clipboard."
    fi
}
