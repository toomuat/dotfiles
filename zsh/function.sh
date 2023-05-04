cdls() {
  if [[ -d "$1" ]]; then
    cd "$1" || return
    ls
  else
    echo "$1 is not a valid directory"
  fi
}

mcd() {
  if [[ -d "$1" ]]; then
    mkdir -p "$1"
    cd "$1" || return
  fi
}

backup() {
  if [[ -d "$1" ]]; then
    cp "$1"{,.bak}
  fi
}

gfind() {
  find / -iname "$@" 2>/dev/null
}

lfind() {
  find . -iname "$@" 2>/dev/null
}

search() {
  if [[ $# -ne 1 ]]; then
    echo "Usage: search <word>"
    return 1
  fi

  man "$1" 2>/dev/null || "${BROWSER}" "http://www.google.com/search?q=\"$1\""
}

sqlcsv() {
  if [ $# -lt 2 ]
  then
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

# Cut $1 column
col() {
  var_column="$1"
  awk "{print ${var_column}}"
  # awk -v col="$1" "{print ${col}}"
}

# curlsh : Safer curl
curlsh() {
  local file

  file=$(mktemp -t curlshXXXX) || { echo "Failed creating file"; return; }
  curl -s "$1" > "${file}" || { echo "Failed to curl file"; return; }
  "${EDITOR}" "${file}" || { echo "Editor quit with error code"; return; }
  sh "${file}";
  rm "${file}";
}

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

bib() {
  platex "$1"
  pbibtex "$(basename "$1" .tex)"
  platex "$1"
  platex "$1"
  #platex "$1"
  dvipdfmx "$(basename "$1" .tex)"
}

# https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
fancy-ctrl-z () {
  if [[ $(($#BUFFER)) -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}

delete_until_slash() {
  # Get the current cursor position
  local cur_pos="${CURSOR}"
  # Get the left side string from the current cursor position
  local left_str=${BUFFER[1,${cur_pos}]}
  # Search for the position where "/" appears
  local delete_word_len=${#${left_str##*\/}}
  # local slash_pos=$(( "${#left_str}" - "${delete_word_len}" - 1 ))
  # Delete the string up to the position where "/" appears
  BUFFER="${BUFFER[1,$((cur_pos-delete_word_len))]}${RBUFFER}"
  # Move the cursor to the position where "/" appears
  CURSOR=$((cur_pos-delete_word_len))
}

RED="\e[1;32m"
RED_BOLD="\e[1;4;31m"
YELLOW="\e[01;33m"
RESET="\e[0m"

man() {
  env \
    LESS_TERMCAP_mb="$(printf '%s' "${RED}")" \
    LESS_TERMCAP_md="$(printf '%s' "${RED}")" \
    LESS_TERMCAP_me="$(printf '%s' "${RESET}")" \
    LESS_TERMCAP_se="$(printf '%s' "${RESET}")" \
    LESS_TERMCAP_so="$(printf '%s' "${YELLOW}")" \
    LESS_TERMCAP_ue="$(printf '%s' "${RESET}")" \
    LESS_TERMCAP_us="$(printf '%s' "${RED_BOLD}")" \
    man "$@"
}

gn() {
  git log --all --reverse --pretty=%H | \
    grep -A1 "$(git rev-parse HEAD)" | \
    tail -1 | \
    xargs git checkout
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND="fd --type file --hidden --follow --exclude .git --color=always"
export FZF_DEFAULT_OPTS="--height 90% --reverse --border --ansi --preview 'bat --color=always {}' --bind alt-p:preview-up,alt-n:preview-down"
export FZF_ALT_C_OPTS="--reverse --preview 'tree -C {} | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# fbr : Checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "${branches}" |
    fzf-tmux -d $(( 2 + $(wc -l <<< "${branches}") )) +m) &&
    git checkout "$(echo "${branch}" | sed 's/.* //' | sed 's#remotes/[^/]*/##')"
}

# fshow - git commit browser (enter for show, ctrl-d for diff)
fshow() {
  local out shas sha q k

  FZF_DEFAULT_OPTS="--height 90% --reverse --border --ansi"
  while out=$(
    git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      fzf --multi --no-sort --query="${q}" \
      --print-query --expect=ctrl-d); do
    q=$(head -1 <<< "${out}")
    k=$(head -2 <<< "${out}" | tail -1)
    shas=$(sed "1,2d;s/^[^a-z0-9]*//;/^$/d" <<< "${out}" | awk "{print $1}")
    [ -z "${shas}" ] && continue
    if [ "${k}" = ctrl-d ]; then
      git diff --color=always "${shas}" | cat
    else
      for sha in ${shas}; do
        git show --color=always "${sha}" | cat
      done
    fi
  done
}

# fzf-z-search : Change directory from history
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
# fzf cat
fcat (){
  local selected

  if [ $# = 0 ];then
    selected=$(fd --color=always -t f | fzf)
  else
    if [ -f "$0" ]; then
      selected=$1
    else
      selected=$(fd --color=always -t f | \
        fzf --query "$0")
    fi
  fi

  if [ -n "${selected}" ];then
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

fcd() {
  local dir_name

  dir_name=$(fd --type d | fzf) || return
  cd "${dir_name}" || return
}

# fgf: Fuzzy find git file at arbitary commit
fgf() {
  if [ ! -d ".git" ]; then
    echo "Not in a git repository."
    return
  fi

  local reply commit_id file_lists file

  fzf_result=$(git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" | \
    fzf --no-sort --tiebreak=index --bind=ctrl-s:toggle-sort \
      --expect=enter,ctrl-c,esc)

  reply=$(echo "${fzf_result}" | head -1)
  commit_id=$(echo "${fzf_result}" | grep -o "[a-f0-9]\{7\}")
  [[ -z "${commit_id}" ]] && return

  case "${reply}" in
    enter) ;;
    ctrl-c) return ;;
    esc) return ;;
    *) ;;
  esac

  file_lists=$(git diff --name-only "${commit_id}")
  fzf_result=$(echo "${file_lists}" | \
    fzf --no-sort --tiebreak=index --bind=ctrl-s:toggle-sort \
      --expect=enter,ctrl-c,esc)

  reply=$(echo "${fzf_result}" | head -1)
  file=$(echo "${fzf_result}" | head -2 | tail -1)

  case "${reply}" in
    enter) ;;
    ctrl-c) return ;;
    esc) fgf "$@"; return ;;
    *) echo $? ;;
  esac

  echo "${commit_id} ${file}"
  git show "${commit_id}":"${file}"
}

# fga : Preview modified file
fga() {
  local modified_files selected_files
  modified_files=$(git status --short | awk "{if ($1 == 'M') {print $2}}") &&
    selected_files=$(echo "${modified_files}" | fzf -m)
  echo "${selected_files}"
}

# fpre : preview file of current directory
fpre() {
  fd --type f --hidden --follow --exclude .git | fzf
}

gh-run() {
  if [ $# != 1 ]; then
    echo "Usage: gh-run <workflow>"
    return 1
  fi

  workflow="$1"
  gh workflow run .github/workflows/"${workflow}" --ref "$(git branch --show-current)"
}

gh-watch() {
  if [ $# != 1 ]; then
    echo "Usage: gh-watch <workflow>"
    return 1
  fi

  workflow="$1"
  gh run list --workflow="${workflow}" | \
    grep "$(git branch --show-current)" | \
    cut -f 7 | \
    head -n 1 | \
    xargs gh run watch
}

gh-view() {
  if [ $# != 1 ]; then
    echo "Usage: gh-view <workflow>"
    return 1
  fi

  workflow="$1"
  gh run list --workflow="${workflow}" | \
    grep "$(git branch --show-current)" | \
    cut -f 7 | \
    head -n 1 | \
    xargs gh run view
}

gh-log() {
  if [ $# != 1 ]; then
    echo "Usage: gh-log <workflow>"
    return 1
  fi

  workflow="$1"
  gh run list --workflow="${workflow}" | \
    grep "$(git branch --show-current)" | \
    cut -f 7 | \
    head -n 1 | \
    xargs gh run view --log
}
