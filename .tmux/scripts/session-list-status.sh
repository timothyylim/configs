#!/bin/bash

# List all sessions with icons for the status bar
# Current session is highlighted with brackets
# Sessions where Claude has finished show a ✓

DONE_FILE="$HOME/.claude/done-sessions"
current=$(tmux display-message -p '#{session_name}')

# Clear current session from done list (we've seen it)
if [[ -f "$DONE_FILE" ]]; then
    current_stripped=$(echo "$current" | sed 's/^. //')
    grep -v "^${current}$" "$DONE_FILE" | grep -v "^${current_stripped}$" > "${DONE_FILE}.tmp" 2>/dev/null
    mv "${DONE_FILE}.tmp" "$DONE_FILE" 2>/dev/null
fi

# Read done sessions into a list
done_sessions=""
if [[ -f "$DONE_FILE" ]]; then
    done_sessions=$(cat "$DONE_FILE")
fi

output=""
while read real_name; do
    stripped=$(echo "$real_name" | sed 's/^. //')
    formatted=$(echo "$stripped" | bash ~/.tmux/scripts/format-sessions.sh)

    # Check if this session has a completed Claude agent
    if echo "$done_sessions" | grep -qF "$stripped" 2>/dev/null || echo "$done_sessions" | grep -qF "$real_name" 2>/dev/null; then
        formatted="$formatted ✓"
    fi

    if [[ "$real_name" == "$current" ]]; then
        formatted="[$formatted]"
    fi

    if [[ -n "$output" ]]; then
        output="$output  $formatted"
    else
        output="$formatted"
    fi
done < <(tmux list-sessions -F '#{session_name}' | sort)

echo "$output"
