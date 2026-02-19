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

# Make tmux scripts executable
if [[ -d "$CONFIGS_DIR/.tmux/scripts" ]]; then
    chmod +x "$CONFIGS_DIR"/.tmux/scripts/*.sh 2>/dev/null || true
    echo "✓ Made tmux scripts executable"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "Optional: Add $CONFIGS_DIR/hugo-build-and-push.sh to your PATH"
