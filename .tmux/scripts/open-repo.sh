#!/bin/bash

selected=$(ls -d ~/repos/*/ 2>/dev/null | xargs -n1 basename | fzf --no-border --no-scrollbar --padding 2,4)

if [[ -n "$selected" ]]; then
    # Switch to existing window if one matches, otherwise create new
    existing=$(tmux list-windows -F '#{window_index} #{window_name}' | awk -v name="$selected" '$2 == name {print $1; exit}')
    if [[ -n "$existing" ]]; then
        tmux select-window -t "$existing"
    else
        tmux new-window -c "$HOME/repos/$selected" -n "$selected"
    fi
fi
