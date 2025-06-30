# プロンプト色設定 (Zshの組み込み機能を使用)
# %F{color} で色を設定し、%f でリセット
# 256色モードの場合、%F{XXX} で直接色コードを指定可能

# 左プロンプトの定義（ユーザー名とカレントディレクトリを色付きで表示）
# %C: カレントディレクトリ
# %(?.true_text.false_text): 直前のコマンドの終了ステータスに応じて表示を切り替え
PROMPT="(%F{080}%C%f) %(?.%F{10}✔%f.%F{9}✘%f) $ "

# Timer variables
typeset -g _last_command_start_ms
typeset -g _last_command_duration

# Function to record command start time
_preexec_timer() {
    _last_command_start_ms=$(printf "%.0f" $((EPOCHREALTIME * 1000)))
}

# Function to calculate and format command duration
# コマンド実行後に呼ばれる関数。実行時間を計算してフォーマットし、右プロンプトに表示する
_precmd_timer() {
    if [[ -n "$_last_command_start_ms" ]]; then
        # 現在時刻（ミリ秒）を取得
        local end_ms=$(printf "%.0f" $((EPOCHREALTIME * 1000)))
        # 実行時間を計算（ミリ秒単位）
        local duration_ms=$((end_ms - _last_command_start_ms))

        # 1秒以上の場合は秒単位で表示（小数点1桁）
        if ((duration_ms >= 1000)); then
            local duration_s=$(awk "BEGIN { printf \"%.1f\", ${duration_ms} / 1000 }")
            _last_command_duration="(${duration_s}s)"
        # 1秒未満でかつ実行時間が0より大きい場合はミリ秒で表示
        elif ((duration_ms > 0)); then
            _last_command_duration="(${duration_ms}ms)"
        # 実行時間が0以下の場合は非表示
        else
            _last_command_duration=""
        fi
        # 開始時刻をクリア
        unset _last_command_start_ms
    else
        # 開始時刻が記録されていない場合は空にする
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
