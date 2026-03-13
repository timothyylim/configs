#!/bin/bash
# Show notification; clicking it focuses the correct Alacritty window
SESSION=$(tmux display-message -p '#{session_name}' 2>/dev/null)
[ -z "$SESSION" ] && exit 0

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

terminal-notifier \
  -title "Claude Code" \
  -message "Ready in session: $SESSION" \
  -sender io.alacritty \
  -execute "$SCRIPT_DIR/raise-alacritty.sh $SESSION"
