#!/bin/bash
set -e

CONFIGS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up symlinks from $CONFIGS_DIR..."

# Helper function to create symlink
link_config() {
    local source="$1"
    local target="$2"

    if [[ -e "$target" ]] && [[ ! -L "$target" ]]; then
        echo "⚠️  $target already exists (not a symlink). Backing up to ${target}.bak"
        mv "$target" "${target}.bak"
    fi

    if [[ -L "$target" ]]; then
        rm "$target"
    fi

    mkdir -p "$(dirname "$target")"
    ln -s "$source" "$target"
    echo "✓ Linked: $target → $source"
}

# Create symlinks
link_config "$CONFIGS_DIR/nvim" "$HOME/.config/nvim"
link_config "$CONFIGS_DIR/alacritty" "$HOME/.config/alacritty"
link_config "$CONFIGS_DIR/.zshrc" "$HOME/.zshrc"
link_config "$CONFIGS_DIR/.tmux.conf" "$HOME/.tmux.conf"
link_config "$CONFIGS_DIR/.tmux/scripts" "$HOME/.tmux/scripts"
link_config "$CONFIGS_DIR/.claude/statusline-command.sh" "$HOME/.claude/statusline-command.sh"
link_config "$CONFIGS_DIR/.claude/themes/fireplace.json" "$HOME/.claude/themes/fireplace.json"

# Screenshot watcher launchd agent
link_config "$CONFIGS_DIR/scripts/com.tim.watch-screenshots.plist" "$HOME/Library/LaunchAgents/com.tim.watch-screenshots.plist"

# Make tmux scripts executable
if [[ -d "$CONFIGS_DIR/.tmux/scripts" ]]; then
    chmod +x "$CONFIGS_DIR"/.tmux/scripts/*.sh 2>/dev/null || true
    echo "✓ Made tmux scripts executable"
fi

if [[ -f "$CONFIGS_DIR/.claude/statusline-command.sh" ]]; then
    chmod +x "$CONFIGS_DIR/.claude/statusline-command.sh"
    echo "✓ Made Claude statusline executable"
fi

# Install tmux terminfo with explicit truecolor capabilities for Ghostty/tmux.
if command -v tic >/dev/null 2>&1 && [[ -f "$CONFIGS_DIR/terminfo/tmux-256color.src" ]]; then
    tic -x -o "$HOME/.terminfo" "$CONFIGS_DIR/terminfo/tmux-256color.src"
    echo "✓ Installed tmux-256color terminfo"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "Optional: Add $CONFIGS_DIR/hugo-build-and-push.sh to your PATH"
