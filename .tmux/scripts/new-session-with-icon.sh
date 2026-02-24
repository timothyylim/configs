#!/bin/bash

# Array of unicode icons (general purpose)
icons=(
    "✨" "❄️" "🔨" "⊕" "◆" "⚡" "🦈" "🔷" "⊙"
    "🌙" "☀️" "🔥" "💧" "🌿" "🎯" "🎨" "🎭" "🎪"
    "🚀" "🛸" "🎸" "🎹" "🎺" "🎻" "📚" "🔬" "⚙️"
)

# Medicinal icons (unicode symbols)
medicinal=(
    "⚕" "♨" "⟨⟩" "✚" "⧬" "⬚" "◈" "⬟" "▣"
)

# Check mode: "new" for new session, or session name for backfill
if [[ "$1" != "new" ]]; then
    # Backfill: rename existing session
    session_name="$1"
    icon="${medicinal[$RANDOM % ${#medicinal[@]}]}"
    tmux rename-session -t "$session_name" "$icon$session_name" 2>/dev/null || echo "Session $session_name not found"
else
    # New session: name provided as second argument
    session_name="$2"
    if [[ -n "$session_name" ]]; then
        icon="${icons[$RANDOM % ${#icons[@]}]}"
        tmux new-session -s "$icon$session_name" -d
        tmux switch-client -t "$icon$session_name"
    fi
fi
