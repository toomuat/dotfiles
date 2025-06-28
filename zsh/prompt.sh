# プロンプト色設定 (Zshの組み込み機能を使用)
# %F{color} で色を設定し、%f でリセット
# 256色モードの場合、%F{XXX} で直接色コードを指定可能

# 左プロンプトの定義（ユーザー名とカレントディレクトリを色付きで表示）
# %C: カレントディレクトリ
# %(?.true_text.false_text): 直前のコマンドの終了ステータスに応じて表示を切り替え
PROMPT="(%F{080}%C%f) %(?.%F{10}✔%f.%F{9}✘%f) $ "

# Timer variables
typeset -g _last_command_start_time
typeset -g _last_command_duration

# Function to record command start time
_preexec_timer() {
    _last_command_start_time=$(date +%s.%N) # Seconds with nanoseconds
}

# Function to calculate and format command duration
_precmd_timer() {
    if [[ -n "$_last_command_start_time" ]]; then
        local end_time=$(date +%s.%N)
        local duration=$(awk "BEGIN { printf \"%.3f\", ${end_time} - ${_last_command_start_time} }")

        if (($(awk "BEGIN { print (${duration} >= 1) }"))); then
            _last_command_duration="(${duration}s)"
        elif (($(awk "BEGIN { print (${duration} > 0) }"))); then
            _last_command_duration="($(awk "BEGIN { printf \"%.0f\", ${duration} * 1000 }")ms)"
        else
            _last_command_duration=""
        fi
        unset _last_command_start_time
    else
        _last_command_duration=""
    fi
}

# 右プロンプトにgitブランチと状態を表示する関数
typeset -g _git_prompt_status
rprompt-git-current-branch() {
    local branch_name st branch_status
    _git_prompt_status="" # Reset for each call

    st=$(git status 2>&1)
    if [ $? -ne 0 ]; then
        return
    fi

    branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    st=$(git status 2>/dev/null)
    if echo "${st}" | grep -q "^nothing to"; then
        branch_status="%F{green}"
    elif echo "${st}" | grep -q "^Untracked files"; then
        branch_status="%F{red}?"
    elif echo "${st}" | grep -q "^Changes not staged for commit"; then
        branch_status="%F{red}+"
    elif echo "${st}" | grep -q "^Changes to be committed"; then
        branch_status="%F{yellow}!"
    elif echo "${st}" | grep -q "^rebase in progress"; then
        echo "%F{red}!(no branch)"
        return
    else
        branch_status="%F{blue}"
    fi
    _git_prompt_status="${branch_status}[$branch_name]%f"
}

# 右プロンプトを構築する関数
_set_rprompt() {
    local rprompt_str=""

    # 時刻を追加
    rprompt_str+="%T"

    # 実行時間を追加
    if [[ -n "$_last_command_duration" ]]; then
        rprompt_str+=" ${_last_command_duration}"
    fi

    # Gitステータスを追加
    if [[ -n "$_git_prompt_status" ]]; then
        rprompt_str+=" ${_git_prompt_status}"
    fi

    RPROMPT="${rprompt_str}"
}

# シェル起動時に右プロンプトを初期化
# RPROMPTは_set_rpromptで設定されるため、ここでは不要
# RPROMPT="$(rprompt-git-current-branch)"

# コマンド実行後に右プロンプトを更新するフックを追加
autoload -Uz add-zsh-hook
add-zsh-hook preexec _preexec_timer
add-zsh-hook precmd _precmd_timer
add-zsh-hook precmd rprompt-git-current-branch
add-zsh-hook precmd _set_rprompt
