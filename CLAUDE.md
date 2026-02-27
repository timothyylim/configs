# CLAUDE.md

## What This Is

Dotfiles repo. All configs live here and are symlinked to their active locations via `setup.sh`. Changes are immediately live.

## Git Workflow

**Always push after changes.** Edit here, commit, push.

## Structure

```
configs/
├── alacritty/          # Terminal emulator (Solarized, FiraCode Nerd Font)
│   ├── alacritty.toml
│   ├── toggle-theme.sh # Ctrl+b T or 'tt' alias
│   ├── open-alacritty-here.sh
│   └── themes/
├── nvim/               # Neovim (lazy.nvim plugin manager)
│   ├── init.lua        # Entry point + all core settings
│   └── lua/plugins/    # telescope, nvim-tree, vim-markdown, zen-mode
├── .tmux.conf          # Tmux config
├── .tmux/scripts/      # Session icons, pomodoro status, world time
├── .obsidian/          # Obsidian vault settings
├── sounds/             # SCV notification sounds (Claude Code hooks)
├── .zshrc              # Shell config (vi mode, aliases, functions)
├── setup.sh            # Creates all symlinks
└── hugo-build-and-push.sh
```

## Symlinks (managed by setup.sh)

- `alacritty/` → `~/.config/alacritty`
- `nvim/` → `~/.config/nvim`
- `.zshrc` → `~/.zshrc`
- `.tmux.conf` → `~/.tmux.conf`
- `.tmux/scripts/` → `~/.tmux/scripts`

## Rules for LLMs

1. **Never edit files outside this repo** — everything goes in `~/repos/configs/`, symlinks handle the rest
2. **New scripts/configs** → add to this repo, add symlink to `setup.sh`, run `./setup.sh`
3. **Never copy files to `~/`** — always symlink
4. **All configs use Solarized** color scheme
5. **Commit and push** after every change
