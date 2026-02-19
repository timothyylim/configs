#!/bin/bash
CONFIG="$HOME/.config/alacritty/alacritty.toml"
STATE_FILE="$HOME/.config/alacritty/.theme_state"

# Read current state (default to dark)
CURRENT=$(cat "$STATE_FILE" 2>/dev/null || echo "dark")

if [ "$CURRENT" = "dark" ]; then
    # Switch to light
    sed -i '' 's|solarized-dark.toml|solarized-light.toml|' "$CONFIG"
    echo "light" > "$STATE_FILE"
else
    # Switch to dark
    sed -i '' 's|solarized-light.toml|solarized-dark.toml|' "$CONFIG"
    echo "dark" > "$STATE_FILE"
fi
