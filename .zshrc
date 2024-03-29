# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# ZSH_THEME="ys"
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="miloshadzic"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)

plugins=(history-substring-search git tmux rvm)
JIRA_RAPID_BOARD="true" 

DISABLE_CORRECTION="true"
DISABLE_AUTO_UPDATE="true"

bindkey "^[[A" up-line-or-beginning-search 
bindkey "^[[B" down-line-or-beginning-search 

source $ZSH/oh-my-zsh.sh

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# -------------------------------------------------------------------
# Git aliases
# -------------------------------------------------------------------

alias ga='git add -A'
alias py='python'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias gta='git tag -a -m'
alias gf='git reflog'

# -------------------------------------------------------------------
# Capistrano aliases
# -------------------------------------------------------------------
 
alias capd='bundle exec cap qa deploy'
alias capdm='bundle exec cap qa deploy:migrations'

# -------------------------------------------------------------------
# OTHER aliases
# -------------------------------------------------------------------
 
alias cl='clear'
alias vim='mvim -v'
alias -g G='|grep '
alias -s html=vim
alias -s erb=vim
alias -s rb=vim

alias tks='tmux kill-server'
alias dw='mux start sourcing'
alias rl='cap pgbackups:capture && rake devops:db:full_reload'
alias rdbm='rake db:migrate'
alias rdbtp='rake db:test:prepare'
unsetopt correct_all

export EDITOR='vim'

bindkey -v # vim mode in zsh
