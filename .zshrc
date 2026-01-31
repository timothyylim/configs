# ====================================================================
# 1. CORE SETTINGS & INITIALIZATION
# ====================================================================

# Enable extended globbing (e.g., recursive globbing for dotfiles)
setopt EXTENDED_GLOB

# Allow 'cd' without explicitly typing 'cd'
setopt AUTO_CD

# History settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS

# Set locale for consistent behavior
export LC_ALL=en_US.UTF-8

# Vim mode for command line editing
bindkey -v
export KEYTIMEOUT=1


# ====================================================================
# 2. PATH MANAGEMENT
# ====================================================================

# --- Primary System/Brew Paths ---
# Standard system paths
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

# Homebrew paths (use 'brew --prefix' for dynamically adding install paths)
export PATH="/opt/homebrew/bin:$(brew --prefix)/bin:$PATH"

# --- Tool-Specific Paths ---
# Go path
export PATH=$PATH:$HOME/go/bin

# PostreSQL (Keep only the versions you actively need)
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# Change Directory Path: Set where 'cd' searches for directories
export CDPATH=".:/Users/tim/repos"


# ====================================================================
# 3. TOOL LOADING & CONFIGURATION
# ====================================================================

# GPG Key
export GPG_TTY=$(tty)

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# RBENV (Ruby Version Manager)
export PATH="/Users/tim/.rbenv/shims:${PATH}"
export RBENV_SHELL=zsh
command rbenv rehash 2>/dev/null
rbenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi
  case "$command" in
    rehash|shell)
    eval "$(rbenv "sh-$command" "$@")";;
    *)
    command rbenv "$command" "$@";;
    esac
}


# ====================================================================
# 4. PROMPT & VCS INTEGRATION
# ====================================================================

# Function to extract Git branch name
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

# Zsh vcs_info settings for Git integration in the prompt
zstyle ':vcs_info:git:*' formats '%b '

# Prompt Colors
COLOR_DEF=$'%f'   # Default color reset
COLOR_USR=$'%F{243}' # Dark gray
COLOR_DIR=$'%F{197}' # Pink/Magenta for current directory
COLOR_GIT=$'%F{39}'  # Blue for git branch

# Function to add an empty line before the prompt
prompt_newline() {
    print -P ''
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd prompt_newline

# Set the actual prompt
setopt PROMPT_SUBST
export PROMPT='$(basename $PWD) ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}$ '


# ====================================================================
# 5. ALIASES & FUNCTIONS
# ====================================================================

# --- Editor Environment ---
if command -v nvim >/dev/null 2>&1; then
    export EDITOR=nvim
    export VISUAL="$EDITOR"
else 
    export EDITOR=vim
    export VISUAL="$EDITOR"
fi

# --- Directory & Source Aliases ---
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias repos='cd ~/repos'
alias src='source ~/.zshrc; echo "ZSH aliases sourced."'
alias config='nvim ~/.zshrc'

# --- Editor Aliases ---
alias v='nvim'
alias c='cursor'
alias nconf='nvim ~/.config/nvim/init.lua'
alias changkat='v /Users/tim/repos/writing/changkat/content/posts'
alias diary='${EDITOR} ~/repos/notes/diary-$(date +%Y-%m-%d).md'
alias scratch='${EDITOR} ~/repos/scratch/$(date +%Y-%m-%d).md'
alias todo='cd ~/repos/visions; ${EDITOR} todo.md'

# --- Git Aliases ---
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'
alias gac='git commit -a -m'
alias gst='git status'
alias glo='git log --pretty="oneline"'
alias glol='git log --graph --oneline --decorate'
alias grv='git remote -v'
alias gd='git diff'

# --- Utility Aliases ---
alias wk='date +%V'
alias pw='watch -n 10 pomodoro status'
alias gf="gemini --model 'gemini-2.5-flash'"
alias g="gemini"
alias ls='eza -1'
alias lsl='eza'

# --- Functions ---

# Fuzzy Search Function (f)
function f() {
    (RELOAD='reload:rg --column --color=always --smart-case {q} || :'
    fzf --disabled --ansi \
        --bind "start:$RELOAD" --bind "change:$RELOAD" \
        --bind 'enter:become:cursor -g {1}:{2}' \
        --delimiter : \
        --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
        --preview-window '~4,+{2}+4/3,<80(up)')
    }

# Open Function (o)
function o () {
    [ "$#" -eq 0 ] && open . || open "$1"
}

# Hugo Serve (hs)
hs() {
    local project_dir=~/repos/writing/$1
    if [ -d "$project_dir" ]; then
        open http://localhost:1313
        (cd "$project_dir" && hugo server)
    else
        echo "Project directory $project_dir does not exist."
    fi
}

# Hugo Push (hp)
hp() {
    local project_dir=~/repos/writing/$1
    if [ -d "$project_dir" ]; then
        ~/repos/configs/hugo-build-and-push.sh "$project_dir"
    else
        echo "Project directory $project_dir does not exist."
    fi
}


# ====================================================================
# 6. KEY BINDINGS & COMPLETION
# ====================================================================

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Edit command with $EDITOR (Ctrl+V)
autoload edit-command-line
zle -N edit-command-line
bindkey '^V' edit-command-line


# ====================================================================
# 7. TMUX STARTUP LOGIC
# ====================================================================

# TODO
export PATH="/opt/homebrew/lib/ruby/gems/3.4.0/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export AGENTMAIL_API_KEY=am_29c0dfff19e4da339da8289fcc743798723ed9da1cf4ae03c84c8f7b75d6b8d9
export AGENTMAIL_API_KEY=am_29c0dfff19e4da339da8289fcc743798723ed9da1cf4ae03c84c8f7b75d6b8d9
