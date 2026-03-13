#!/bin/bash
# Raise the Alacritty window matching the given tmux session name
SESSION="$1"
[ -z "$SESSION" ] && exit 0

osascript <<EOF
tell application "System Events"
    tell process "Alacritty"
        set frontmost to true
        try
            perform action "AXRaise" of (first window whose name contains "$SESSION")
        end try
    end tell
end tell
EOF
