#!/bin/bash

# Build tab-separated lines: formatted\treal_name
tmpfile=$(mktemp)
while read real_name; do
    stripped=$(echo "$real_name" | sed 's/^. //')
    formatted=$(echo "$stripped" | bash ~/.tmux/scripts/format-sessions.sh)
    printf '%s\t%s\n' "$formatted" "$real_name" >> "$tmpfile"
done < <(tmux list-sessions -F '#{session_name}' | sort -r)

# Show formatted names in fzf
selected=$(cut -f1 "$tmpfile" | fzf --no-border --no-scrollbar --padding 2,4)

if [[ -n "$selected" ]]; then
    real=$(awk -F'\t' -v sel="$selected" '$1 == sel {print $2; exit}' "$tmpfile")
    tmux switch-client -t "$real"
fi

rm -f "$tmpfile"
