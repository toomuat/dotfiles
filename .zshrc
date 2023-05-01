if [[ "$OSTYPE" == "darwin"* ]]; then
  source ~/.mac.zshrc
elif [[ "$(uname -r)" =~ "microsoft" ]]; then
  source ~/.wsl.zshrc
fi

export LANG=C.UTF-8
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0
export EDITOR=/usr/local/bin/nvim
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=01;34:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:"
export LESS=" -g -i -M -R -S -W -z-4 -x4 -Q -j10"
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
# Append history to the history file (no overwriting)
setopt appendhistory
# Share history across terminals
setopt sharehistory
# Immediately append to the history file, not just when a term is killed
setopt incappendhistory

export NVIM=$HOME/.config/nvim
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export GOPATH=$HOME/.go
export PATH=$PATH:$HOME/.cargo/bin

alias x="exit"
alias l="ls"
alias ls="ls --color=auto"
alias ll="ls -al"
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias grep="grep --color=auto"
alias gdb="gdb -q"
alias v="/usr/local/bin/nvim"
alias c="code"
alias gh-run="gh workflow run .github/workflows/$workflow --ref $(git branch --show-current)"
alias gh-watch="gh run list --workflow=$workflow | grep $(git branch --show-current) | cut -f 7 | head -n 1 | xargs gh run watch"
alias gh-view="gh run list --workflow=$workflow | grep $(git branch --show-current) | cut -f 7 | head -n 1 | xargs gh run view"
alias gh-log="gh run list --workflow=$workflow | grep $(git branch --show-current) | cut -f 7 | head -n 1 | xargs gh run view --log"

alias g="git"
alias ga="git add"
alias gap="git add -p"
alias gcm="git commit -m"
alias gc="git clone"
alias gch="git checkout"
alias gb="git branch"
alias gp="git push"
alias gpom="git push origin main"
alias glp="git log -p"
alias gln="git log --name-status --oneline"
alias gl="git log --pretty='format:%C(yellow)%h %C(green)%cd %C(reset)%s %C(red)%d %C(cyan)[%an]' --date=format:'%c' --all --graph"
alias gt="git log --graph --date=format:'%Y/%m/%d %H:%M:%S'  --all --pretty=format:\"%C(cyan bold)%an%Creset [%cd] %C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s\" --name-only"
alias gs="git status -sb"
alias gtag="git tag"
alias gsw="git switch"
alias gd="git diff"
alias gsh="git show"
alias grb="git rebase"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias gcp="git cherry-pick"
alias gst="git stash"
alias gsl="git stash list"
alias grl="git reflog"
alias gls="git ls-files"
alias glt="git ls-tree"
alias gfile="git diff-tree --no-commit-id --name-only -r $1"

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

GREEN="%{\e[38;5;118m%}"
YELLOW="%{\e[38;5;190m%}"
CYAN="%{\e[38;5;080m%}"
USER_NAME=%n
CURRENT_DIR=%C
RESET="%{\e[0m%}"
PROMPT=$"%{\e[38;5;118m%}[%{\e[0m%}%{\e[38;5;190m%}%n%{\e[0m%}:%{\e[38;5;080m%}%C%{\e[0m%}%{\e[38;5;118m%}]%{\e[0m%}$ "

cdls() {
  if [[ -d "$1" ]]; then
    cd "$1"
    ls
  else
    echo "$1 is not a valid directory"
  fi
}

mcd() {
  if [[ -d "$1" ]]; then
    mkdir -p $1
    cd $1
  fi
}

backup() {
  if [[ -d "$1" ]]; then
    cp "$1"{,.bak}
  fi
}

gfind() {
  find / -iname $@ 2>/dev/null
}

lfind() {
  find . -iname $@ 2>/dev/null
}

search() {
  man $@ 2>/dev/null || $BROWSER "http://www.google.com/search?q=$@"
}

sqlcsv() {
  if [ $# -lt 2 ]
  then
    echo "USAGE: sqlcsv [filename.csv] [SQL]"
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
      -cmd '.import "${filename}" "${dataname}"' \
      -cmd ${sql_query}
  fi
}

# Cut $1 column
col() {
  awk -v col=$1 "{print ${col}}"
}

# curlsh : Safer curl
curlsh() {
  local file

  file=$(mktemp -t curlshXXXX) || { echo "Failed creating file"; return; }
  curl -s "$1" > ${file} || { echo "Failed to curl file"; return; }
  ${EDITOR} ${file} || { echo "Editor quit with error code"; return; }
  sh ${file};
  rm ${file};
}

rc(){
  local filepath="$1"
  local extension="${filepath##*.}"
  if [[ ! "${extension}" == "rs" ]]; then
    return 1
  else

  local name=$(basename $1 .rs)
  rustc $@
  ./"${name}"
  rm "${name}"
}

bib(){
  platex $1
  pbibtex $(basename $1 .tex)
  platex $1
  platex $1
  #platex $1
  dvipdfmx $(basename $1 .tex)
}

rprompt-git-current-branch() {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    return
  fi

  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # Displays green if all files are committed and clean
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # Displays red if there are untracked files not managed by git
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # Displays red if there are files added to the repo but not staged
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # Displays yellow if there are changes to be committed
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # Displays red with an exclamation point if there is a conflict
    echo "%F{red}!(no branch)"
    return
  else
    # Displays blue if the status is not any of the above
    branch_status="%F{blue}"
  fi
  # Displays the branch name with color
  echo "${branch_status}[$branch_name]%f"
}

RPROMPT='`rprompt-git-current-branch`'

# https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}

delete_until_slash() {
  # Get the current cursor position
  local cur_pos=$(echo $CURSOR)
  # Get the left side string from the current cursor position
  local left_str=${BUFFER[1,${cur_pos}]}
  # Search for the position where "/" appears
  local delete_word_len=${#${left_str##*\/}}
  local slash_pos=$(( ${#left_str} - ${delete_word_len} - 1 ))
  # Delete the string up to the position where "/" appears
  BUFFER=${BUFFER[1,$((cur_pos-delete_word_len))]}$RBUFFER
  # Move the cursor to the position where "/" appears
  CURSOR=$((cur_pos-delete_word_len))
}

RED="\e[1;32m"
RED_BOLD="\e[1;4;31m"
YELLOW="\e[01;33m"
RESET="\e[0m"

man() {
  env \
    LESS_TERMCAP_mb=$(printf "${RED}")   \
    LESS_TERMCAP_md=$(printf "${RED}")   \
    LESS_TERMCAP_me=$(printf "${RESET}")      \
    LESS_TERMCAP_se=$(printf "${RESET}")      \
    LESS_TERMCAP_so=$(printf "${YELLOW}")  \
    LESS_TERMCAP_ue=$(printf "${RESET}")      \
    LESS_TERMCAP_us=$(printf "${RED_BOLD}") \
    man "$@"
}

gn() {
  git log --all --reverse --pretty=%H | \
    grep -A1 $(git rev-parse HEAD) | \
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
    git checkout $(echo "${branch}" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
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
      git diff --color=always ${shas} | cat
    else
      for sha in ${shas}; do
        git show --color=always ${sha} | cat
      done
    fi
  done
}

# fzf-z-search : Change directory from history
fzf-z-search() {
  local res=$(z | sort -rn | cut -c 12- | fzf)
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
    if [ -f $0 ]; then
      selected=$1
    else
      selected=$(fd --color=always -t f | \
        fzf --query "$0")
    fi
  fi

  if [ -n "${selected}" ];then
    print -s "bat ${selected}"
    bat ${selected}
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
  cd "${dir_name}"
}

# fgf: Fuzzy find git file at arbitary commit
fgf() {
  if [ ! -d ".git" ]; then
    echo "Not in a git repository."
    return
  fi
  echo fgf

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
    *) echo $? ;;
  esac

  file_lists=$(git diff --name-only ${commit_id})
  fzf_result=$(echo $file_lists | \
    fzf --no-sort --tiebreak=index --bind=ctrl-s:toggle-sort \
      --expect=enter,ctrl-c,esc)

  reply=$(echo "${fzf_result}" | head -1)
  file=$(echo "${fzf_result}" | head -2 | tail -1)

  case "${reply}" in
    enter) ;;
    ctrl-c) return ;;
    esc) fgf; return ;;
    *) echo $? ;;
  esac

  echo ${commit_id} ${file}
  git show ${commit_id}:${file}
}

# fga : Preview modified file
fga() {
  local modified_files=$(git status --short | awk "{if ($1 == "M") {print $2}}") &&
  local selected_files=$(echo "${modified_files}" | fzf -m)
}

# fpre : preview file of current directory
fpre() {
  fd --type f --hidden --follow --exclude .git | fzf
}

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

