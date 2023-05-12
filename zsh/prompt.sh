GREEN="%{\e[38;5;118m%}"
YELLOW="%{\e[38;5;190m%}"
CYAN="%{\e[38;5;080m%}"
USER_NAME=%n
CURRENT_DIR=%C
RESET="%{\e[0m%}"

PROMPT=$'%{\e[38;5;118m%}[%{\e[0m%}%{\e[38;5;190m%}%n%{\e[0m%}:%{\e[38;5;080m%}%C%{\e[0m%}%{\e[38;5;118m%}]%{\e[0m%}$ '

rprompt-git-current-branch() {
  local branch_name st branch_status

  if [ ! -e ".git" ]; then
    RPROMPT=""
    return
  fi

  branch_name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  st=$(git status 2> /dev/null)
  if echo "${st}" | grep -q "^nothing to"; then
    # Displays green if all files are committed and clean
    branch_status="%F{green}"
  elif echo "${st}" | grep -q "^Untracked files"; then
    # Displays red if there are untracked files not managed by git
    branch_status="%F{red}?"
  elif echo "${st}" | grep -q "^Changes not staged for commit"; then
    # Displays red if there are files added to the repo but not staged
    branch_status="%F{red}+"
  elif echo "${st}" | grep -q "^Changes to be committed"; then
    # Displays yellow if there are changes to be committed
    branch_status="%F{yellow}!"
  elif echo "${st}" | grep -q "^rebase in progress"; then
    # Displays red with an exclamation point if there is a conflict
    echo "%F{red}!(no branch)"
    return
  else
    # Displays blue if the status is not any of the above
    branch_status="%F{blue}"
  fi
  # Displays the branch name with color
  # echo "${branch_status}[$branch_name]%f"
  RPROMPT="${branch_status}[$branch_name]%f"
}

RPROMPT="$(rprompt-git-current-branch)"

autoload -Uz add-zsh-hook
add-zsh-hook precmd rprompt-git-current-branch
