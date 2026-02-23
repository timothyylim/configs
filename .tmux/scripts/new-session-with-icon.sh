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

# Check if we're backfilling (session name provided as argument)
if [[ -n "$1" ]]; then
    # Backfill: rename existing session
    session_name="$1"
    icon="${medicinal[$RANDOM % ${#medicinal[@]}]}"
    tmux rename-session -t "$session_name" "$icon $session_name" 2>/dev/null || echo "Session $session_name not found"
else
    # New session: prompt for name and add random icon
    read -p "New session name: " session_name
    if [[ -n "$session_name" ]]; then
        icon="${icons[$RANDOM % ${#icons[@]}]}"
        tmux new-session -s "$icon $session_name" -d
        echo "Created session: $icon $session_name"
    fi
fi
