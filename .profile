#!/usr/bin/env bash

# maintain: Kamontat Chantrachirathumrong
# version:  1.5.0
# since:    04/11/2017

# vim key
set -o vi

# set default variable
export USER="kamontat"
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# User configuration
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export ARCHFLAGS="-arch x86_64"
export EDITOR='nvim'
export VISUAL='nvim'

# default path
# set bin library location
export PATH="/usr/bin:$PATH"                                                                 # user bin
export PATH="/bin:$PATH"                                                                     # bin
export PATH="/usr/sbin:$PATH"                                                                # user sbin
export PATH="/sbin:$PATH"                                                                    # sbin
export PATH="/usr/local/bin:$PATH"                                                           # local bin
export PATH="/usr/local/sbin:$PATH"                                                          # local sbin
export PATH="/usr/local/git/bin:$PATH"                                                       # git
export PATH="/usr/local/sbin:$PATH"                                                          # new local sbin folder

# ----------------------------------------------
# custom path
# ----------------------------------------------

# core util
export PATH="$PATH:/usr/local/opt/coreutils/libexec/gnubin"                                    # brew util
export GPG_TTY=$(tty)                                                                          # gpg tty
# set python3 location
# export PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:$PATH"                    # python version 3.5
export PATH="/usr/local/opt/openssl/bin:$PATH"                                                 # openssl
export PATH="/usr/local/opt/sqlite/bin:$PATH"                                                  # sqlite
# java home setting
test -n "$JAVA_HOME" && export PATH="$JAVA_HOME/bin:$PATH"                                     # java path
export PATH="$HOME/.jenv/bin:$PATH"                                                            # java version management (brew)
export JAVA_HOME="$(/usr/libexec/java_home)"                                                   # java env
# android
export ANDROID_HOME="$HOME/Library/Android/sdk"                                                # android home
export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"                           # android path
# go lang cli
export PATH=$PATH:/usr/local/go/bin                                                            # go lang
# draw graph by writing code
# http://www.graphviz.org/Documentation.php
export GRAPHVIZ_DOT=/usr/local/bin/dot

### ruby package management
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"                                                             # ruby version management 

### node package management
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"                                            # node version management
    # [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

### python package management
# added by Anaconda3 4.4.0 installer
export PATH="$HOME/miniconda/bin:$PATH"                                                           # miniconda

### java version management
eval "$(jenv init -)"

# aws cli
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$PATH:$HOME/.local/bin"
fi

# postgres setting 
if [ ! -d /etc/paths.d ]; then
    sudo mkdir -p /etc/paths.d &&
    echo /Applications/Postgres.app/Contents/Versions/latest/bin | sudo tee /etc/paths.d/postgresapp
fi

# travis script install gem
[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# ----------------------------------------------
# helper function
# ----------------------------------------------

# $1 => file to output
# $2 => line number (optional)
#       can be single number like 40
#              length        like 14-55
#              multiple      like 12,44,55
function cat-syntax {
    if [ -f "$1" ]; then
        local t
        local T
        # highlight syntax
        t=$(pygmentize "$1" 2>/dev/null || pygmentize -l text "$1")
        # add line number
        T=$(echo "$t" | \cat -n)
        # if have $2
        if [ ! -x "$2" ]; then
            T=$(echo "$T" | grep "$2")
        fi
        echo "$T"
    else 
        echo "require 1 file as parameter."
        return 1
    fi
}

# macOS only
# $1 => file path
# copy file context to copy/paste (cmd-c and cmd-v)
copy_file() {
    [ -f "$1" ] && pbcopy < "$1" || return 2
}

# ----------------------------------------------
# custom alias
# ----------------------------------------------

# new key
alias c='clear'
command -v gls >/dev/null 2>&1 && alias ls='gls --hyperlink=always --indicator-style=classify --color=auto' # brew coreutils
alias l='ls'
alias s='source'
alias srm='sudo rm -rf'
alias la='ls --almost-all --no-group --human-readable --sort=time --format=verbose --time-style="+%d/%m/%Y-%H:%M:%S"'
alias cat='cat-syntax'
alias cdd='cd ~/Desktop'
alias cdp='cd ~/Desktop/my-code-project'
alias rmf='rm -rf'
alias sysinfo='neofetch --config ~/.config/neofetch/config'
alias ui='ranger'
alias atime='gnomon'
alias stime='gnomon'
# git alias
alias git='hub'
alias g='git'
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gcm='gc -m'
alias gcm-sign='gc -S -m'
alias gt='git tag'
alias gta='git tag -a'
alias gt-sign='git tag -s'
alias gco='git checkout'
alias gcod='git checkout dev'
alias gcom='git checkout master'
# gitmoji
alias gj='gitmoji'
alias gji='git init; gj -i'
alias gj_remove='gj --remove'
alias gjc='gj --commit'
alias gj_list='gj --list'
gj_search() {
  gj "$@" --search
}
alias gj_update='gj --update'
# git branch
alias gb='git branch'
alias gba='git branch -a'
alias gbD='git branch -D'
alias gbm='git branch --merged'
alias gbnm='git branch --no-merged'
alias gbr='git fetch --all --prune'  # remove remote branch, If not exist
alias gp='git push'
alias gP='git pull'
# git log
alias gl='git log --graph'           # log with graph and format in git config
alias gl-sign='gl --show-signature'  # log with show sign information
alias gla='gl --all'                 # log all branch and commit
alias glo='gl --oneline'             # log with oneline format
alias glao='gla --oneline'           # log all in oneline format 
alias glss='gl --stat --summary'     # log with stat and summary
alias ge='source activate py35 && gitsome'
alias gitignore='git ignore-io'
# my dot template (https://github.com/kamontat/dot-github-mini)
alias dotgithub='~/.github/dotgithub'
# bash template (https://github.com/Template-Generating/script-genrating)
alias template='bash <(curl -sL https://github.com/Template-Generating/script-genrating/raw/master/template.sh)'
alias color-test='bash <(curl -sL https://raw.githubusercontent.com/kamontat/bash-color/master/color_test.sh)'
# angular custom
alias ngg='git clone https://github.com/Template-Generating/angular-4-browser-sync.git'
# vim
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias vis='sudo nvim'
alias svim='sudo nvim'
# atom

# if command return non-zero code, mean no atom
command -v "atom" >/dev/null 2>&1 || alias atom='atom-beta'
command -v "code" >/dev/null 2>&1 || alias code='code-insiders'
# rails 
alias r='rails'

