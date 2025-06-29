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
export FZF_DEFAULT_OPTS="--height 90% --reverse --border --ansi --no-preview --bind alt-p:preview-up,alt-n:preview-down"
export FZF_ALT_C_OPTS="--reverse --preview 'tree -C {} | head -200'"
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
vf() {
    local file_name

    file_name=$(fzf) || return
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
    if [ ! -d ".git" ]; then
        echo "Not in a git repository."
        return
    fi

    local reply commit_id file_lists file

    fzf_result=$(
        git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" | fzf --no-sort --tiebreak=index --bind=ctrl-s:toggle-sort --expect=enter,ctrl-c,esc --preview 'git show --color=always {}'
    )

    reply=$(echo "${fzf_result}" | head -1)
    commit_id=$(echo "${fzf_result}" | grep -o "[a-f0-9]\\{7\\}")
    [[ -z "${commit_id}" ]] && return

    case "${reply}" in
    enter) ;;
    ctrl-c) return ;;
    esc) return ;;
    *) ;;
    esac

    file_lists=$(git diff --name-only "${commit_id}")
    fzf_result=$(
        echo "${file_lists}" |
            fzf <(echo "${file_lists}") --no-sort --tiebreak=index --bind=ctrl-s:toggle-sort --expect=enter,ctrl-c,esc --preview 'bat --color=always {}'
    )

    reply=$(echo "${fzf_result}" | head -1)
    file=$(echo "${fzf_result}" | head -2 | tail -1)

    case "${reply}" in
    enter) ;;
    ctrl-c) return ;;
    esc)
        fgf "$@"
        return
        ;;
    *) echo $? ;;
    esac

    echo "${commit_id} ${file}"
    git show "${commit_id}":"${file}"
}

# fzfでカレントディレクトリのファイルをプレビュー
fpre() {
    fd --type f --hidden --follow --exclude .git | fzf --preview 'bat --color=always {}'
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
    selected_pr=$(gh pr list --limit 100 | fzf --preview 'gh pr view {} --json body --template "{{.body}}"')
    pr_number=$(echo "${selected_pr}" | awk '{print $1}')
    if [ -n "${pr_number}" ]; then
        gh co "${pr_number}"
    else
        echo "PRが選択されませんでした"
    fi
}

# fzfでPRを選択してwebで表示
ghpv() {
    selected_pr=$(gh pr list --limit 100 | fzf --preview 'gh pr view {} --json body --template "{{.body}}"')
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
