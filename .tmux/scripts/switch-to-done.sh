#!/bin/bash

# Switch to the first session where Claude has completed
DONE_FILE="$HOME/.claude/done-sessions"

if [[ ! -s "$DONE_FILE" ]]; then
    tmux display-message "No completed Claude sessions"
    exit 0
fi

# Get the first done session name
target=$(head -1 "$DONE_FILE")

if [[ -n "$target" ]]; then
    # Try exact match first, then search by stripped name
    if tmux switch-client -t "$target" 2>/dev/null; then
        exit 0
    fi

    # Search for a session containing this name
    while read real_name; do
        stripped=$(echo "$real_name" | sed 's/^. //')
        if [[ "$stripped" == "$target" || "$real_name" == "$target" ]]; then
            tmux switch-client -t "$real_name"
            exit 0
        fi
    done < <(tmux list-sessions -F '#{session_name}')

    tmux display-message "Session '$target' not found"
fi
