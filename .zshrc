cd ~/repos
zstyle ':vcs_info:git:*' formats '%b '
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

export PATH="/opt/homebrew/bin:/usr/local/opt/ruby/bin:$PATH"
# go path
export PATH=$PATH:$HOME/go/bin

# Hyper terminal 
export PATH="/Applications/Hyper.app/Contents/Resources/bin:$PATH"

# Redis
export PATH=$(brew --prefix)/bin:$PATH

# GPG Key
export GPG_TTY=$(tty)

export CDPATH=".:/Users/tim/repos"
setopt AUTO_CD # cd to dir if dir exists and no command is called

function f() {
   (RELOAD='reload:rg --column --color=always --smart-case {q} || :'
    fzf --disabled --ansi \
        --bind "start:$RELOAD" --bind "change:$RELOAD" \
        --bind 'enter:become:cursor -g {1}:{2}' \
        --delimiter : \
        --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
        --preview-window '~4,+{2}+4/3,<80(up)')
    }
# vim mode
bindkey -v
export KEYTIMEOUT=1

# Automatically start tmux on shell startup
# Check if tmux is installed and if we're not already in a tmux session
if command -v tmux &> /dev/null; then
    if [ -z "$TMUX" ]; then
        # Check if a session already exists
        if tmux has-session &> /dev/null; then
            # Attach to an existing session
            tmux attach-session
        else
            # Create a new detached session named "main"
            # and run the specified command in the *first* window, named "changkat".
            tmux new-session -d -s main -n "changkat" "nvim /Users/tim/repos/writing/changkat/content/posts"

            # Create a new window for your todo list.
            # This will be window index 1.
            tmux new-window -t main -n "todo" "nvim /Users/tim/repos/visions/todo.md"
            
            # Create an additional detached session named "dev".
            tmux new-session -d -s dev

            # Attach to the new "dev" session.
            tmux attach-session -t dev
        fi
    fi
fi


# PROMPT ---------------------------------------------------------------------
COLOR_DEF=$'%f'
COLOR_USR=$'%F{243}'
COLOR_DIR=$'%F{197}'
COLOR_GIT=$'%F{39}'

# Adds an empty line before the prompt for visual breatheability
prompt_newline() {
    print -P ''
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd prompt_newline

setopt PROMPT_SUBST
export PROMPT='$(basename $PWD) ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}$ '

# ALIASES --------------------------------------------------------------------

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# git aliases
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'
alias gac='git commit -a -m'
alias gst='git status'
alias glo='git log --pretty="oneline"'
alias glol='git log --graph --oneline --decorate'
alias grv='git remote -v'
alias gd='git diff'

alias v='nvim'
alias c='cursor'
alias wk='date +%V'
# alias ls='ls -G -F'
alias ls='eza -1'
alias lsl='eza'
alias todo='cd ~/repos/visions; vim todo.md'
alias nconf='vim ~/.config/nvim/init.lua'
alias repos='cd ~/repos'
alias zsh='v ~/.zshrc; src'

alias changkat='v /Users/tim/repos/writing/changkat/content/posts'
alias diary='${EDITOR:-nvim} ~/repos/diary/$(date +%Y-%m-%d).md'
alias scratch='${EDITOR:-nvim} ~/repos/scratch/$(date +%Y-%m-%d).md'
alias recall='cd ~/repos/recall/js-recall'

# serve and push hugo sites
hs() {
  local project_dir=~/repos/writing/$1
  if [ -d "$project_dir" ]; then
    open http://localhost:1313
    (cd "$project_dir" && hugo server)
  else
    echo "Project directory $project_dir does not exist."
  fi
}

# alias o="open"
function o () {
  [ "$#" -eq 0 ] && open . || open "$1"
}

# EDITOR --------------------------------------------------------
	
if command -v nvim >/dev/null 2>&1; then
    export EDITOR=nvim
    export VISUAL="$EDITOR"
else 
    export EDITOR=vim
    export VISUAL="$EDITOR"
fi
	
# KEYBINDINGS --------------------------------------------------------

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
	
# Edit command with $EDITOR
autoload edit-command-line
zle -N edit-command-line
bindkey '^V' edit-command-line

# ---- 

hp() {
  local project_dir=~/repos/writing/$1
  if [ -d "$project_dir" ]; then
    ~/repos/configs/hugo-build-and-push.sh "$project_dir"
  else
    echo "Project directory $project_dir does not exist."
  fi
}


# Servers 
alias arrakis='ssh root@64.227.118.57'

# Configs 
alias config='c ~/.zshrc'
alias src='source ~/.zshrc; echo "ZSH aliases sourced."'


# git 
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Source timezone tools
source ~/repos/configs/timezone_tools.zsh


# misc. 
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  

# This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


  export LC_ALL=en_US.UTF-8

export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"


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