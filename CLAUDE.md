# CLAUDE.md

## Repository Overview

This is a **dotfiles repository** for managing configuration files across machines using symlinks. All configs are version-controlled and can be deployed with a single setup script.

## Repository Location

`~/repos/configs/`

## Git Workflow

**IMPORTANT:** Push to the repository after ANY changes to configuration files.

When making changes:
1. Edit files in `~/repos/configs/`
2. Test changes (configs are symlinked to active locations)
3. Commit changes: `git add . && git commit -m "description"`
4. Push to remote: `git push`

## Structure

```
configs/
├── alacritty/               # Terminal emulator config
│   ├── alacritty.toml      # Main config (imports solarized-dark by default)
│   ├── toggle-theme.sh     # Theme switcher script (Ctrl+b T or 'tt')
│   └── themes/
│       ├── solarized-dark.toml
│       └── solarized-light.toml
├── nvim/                    # Neovim editor config
│   ├── init.lua            # Entry point
│   ├── lazy-lock.json      # Plugin versions
│   └── lua/
│       ├── config/
│       │   └── lazy.lua    # Plugin manager setup
│       └── plugins/
│           ├── telescope.lua    # Fuzzy finder
│           └── nvim-tree.lua    # File explorer
├── .zshrc                   # Zsh shell configuration
├── .tmux.conf              # Tmux multiplexer config
├── setup.sh                # Symlink installer
├── hugo-build-and-push.sh  # Hugo deployment script
└── CLAUDE.md              # This file
```

## Setup

Run once on new machines:
```bash
cd ~/repos/configs
./setup.sh
```

This creates symlinks:
- `~/repos/configs/alacritty` → `~/.config/alacritty`
- `~/repos/configs/nvim` → `~/.config/nvim`
- `~/repos/configs/.zshrc` → `~/.zshrc`
- `~/repos/configs/.tmux.conf` → `~/.tmux.conf`

## Configuration Details

### Alacritty (Terminal Emulator)

**Theme:** Solarized Dark/Light toggle
- Default: Solarized Dark
- Font: FiraCode Nerd Font Mono, 14pt
- Opacity: 1.0 (no transparency)
- Cursor: Block, non-blinking

**Toggle theme:**
- In tmux: `Ctrl+b` then `T`
- In terminal: Type `tt`

Theme state stored in `~/.config/alacritty/.theme_state`

### Neovim (Editor)

**Plugin Manager:** lazy.nvim

**Installed Plugins:**
- `nvim-treesitter` - Syntax highlighting
- `nvim-tree.lua` - File explorer
- `telescope.nvim` - Fuzzy finder
- `solarized.nvim` - Color scheme
- `nvim-web-devicons` - File icons

**Key Bindings:**
- `<leader>e` - Toggle file tree
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Switch buffers

**Features:**
- Prose mode auto-enabled for markdown
- Mac clipboard integration
- Status bar only when splitting
- 2-space indentation

### Zsh (Shell)

**Key Features:**
- Vi mode editing (`bindkey -v`)
- Git branch in prompt
- Custom aliases (see below)
- CDPATH set to `~/repos` for quick navigation
- 10,000 command history

**Important Aliases:**
- `src` - Reload .zshrc
- `config` - Edit .zshrc
- `v` - Open nvim
- `nconf` - Edit nvim config
- `tt` - Toggle Alacritty theme
- `ga`, `gc`, `gst`, `gd` - Git shortcuts
- `repos` - cd to ~/repos
- `diary` - Open today's diary
- `todo` - Open todo.md

**Tool Management:**
- NVM (Node Version Manager)
- rbenv (Ruby)
- PostgreSQL 15 & 17

### Tmux (Terminal Multiplexer)

**Plugins (via tpm):**
- `tmux-yank` - Clipboard integration
- `tmux-sensible` - Sensible defaults
- `tmux-resurrect` - Save/restore sessions
- `tmux-continuum` - Auto-save sessions

**Theme:** Solarized Dark (syncs with Alacritty toggle)

**Key Bindings:**
- `Ctrl+b T` - Toggle Alacritty theme
- `h/j/k/l` - Vi-style pane navigation
- `%` - Split horizontal (preserves path)
- `"` - Split vertical (preserves path)
- `c` - New window (preserves path)

**Features:**
- Mouse support enabled
- Auto-restore sessions on restart
- Minimal status bar

## Maintenance

### Adding New Configs

1. Add config directory/file to `~/repos/configs/`
2. Update `setup.sh` with new symlink:
   ```bash
   link_config "$CONFIGS_DIR/newconfig" "$HOME/.config/newconfig"
   ```
3. Run `./setup.sh` to create symlink
4. Commit and push changes

### Updating Configs

When you edit any config file:
```bash
cd ~/repos/configs
git add .
git commit -m "Update <config>: <description>"
git push
```

**Reminder:** Changes are immediately live (due to symlinks), but must be pushed to save to repo.

### Syncing to New Machine

```bash
# Clone repo
git clone <repo-url> ~/repos/configs
cd ~/repos/configs

# Run setup
./setup.sh

# Install tmux plugin manager (if needed)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Inside tmux, install plugins
# Press: Ctrl+b I (capital I)

# Make Alacritty toggle script executable
chmod +x ~/repos/configs/alacritty/toggle-theme.sh

# Reload shell
source ~/.zshrc
```

## Tools Required

- **Alacritty** - Terminal emulator
- **Tmux** - Terminal multiplexer
- **Neovim** - Text editor (v0.9+)
- **Zsh** - Shell
- **Git** - Version control
- **Eza** - Modern ls replacement (`brew install eza`)
- **FiraCode Nerd Font Mono** - Font (for powerline/icons)

## Notes

- All configs use Solarized color scheme for consistency
- File paths use `~/.config/` (XDG standard) where possible
- Symlinks allow editing in `~/repos/configs/` with changes taking effect immediately
- Theme toggle updates both Alacritty and tmux simultaneously
- `setup.sh` backs up existing configs to `.bak` before symlinking
