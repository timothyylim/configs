autoload -Uz vcs_info
premd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# Prompt!
COLOR_DEF=$'%f'
COLOR_USR=$'%F{243}'
COLOR_DIR=$'%F{197}'
COLOR_GIT=$'%F{39}'
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n ${COLOR_DIR}%2~ ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}$ '

# aliases
alias vim='nvim'
alias t='trans en:de'
alias c='cursor'
alias rm='mv -t ~/.Trash'
alias z="c ~/repos/configs/.zshrc"

# projects 
alias tim='cd ~/repos/timothylim.is/; c .'
alias wiki='cd ~/repos/tpot.wiki/; c .'
alias hyper='cd ~/repos/hypertext-collective; c .'
alias perth='cd ~/repos/perth; c .'
alias birdseye='c ~/repos/birds-eye-2'

# scripts
alias hugo-update='hugo-build-and-push.sh'

# Servers 
alias arrakis='ssh root@64.227.118.57'

# Configs 
alias config='vim ~/.zshrc'
alias src='source ~/.zshrc; echo "ZSH aliases sourced."'
alias check-configs='~/repos/scripts/check-configs.sh'

# Run check-configs on startup
~/repos/scripts/check-configs.sh
~/repos/configs/check-visions.sh


# git 
alias g-tree='git log --graph --pretty=oneline --abbrev-commit'
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

# misc. 
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  

# This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


  export LC_ALL=en_US.UTF-8

alias hugo-update='~/repos/scripts/hugo-build-and-push.sh'
