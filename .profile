# maintain: Kamontat Chantrachirathumrong
# version:  1.3.0
# since:    07/09/1017

# vim key
set -o vi

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source $HOME/.rvm/scripts/rvm

# set default variable
export USER="kamontat"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# User configuration
export MANPATH="/usr/local/man:$MANPATH"
export ARCHFLAGS="-arch x86_64"
export EDITOR='vim'

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

# set python3 location
# export PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:$PATH"                    # python version 3.5
export PATH="/usr/local/opt/openssl/bin:$PATH"                                                 # openssl
export PATH="/usr/local/opt/sqlite/bin:$PATH"                                                  # sqlite
# java home setting
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home"            # java home
export PATH="$JAVA_HOME/bin:$PATH"                                                     	       # java path
# android
export ANDROID_HOME="~/Library/Android/sdk"                                                    # android home
export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"                           # android path


# go lang cli
export PATH=$PATH:/usr/local/go/bin

# draw graph by writing code
# http://www.graphviz.org/Documentation.php
export GRAPHVIZ_DOT=/usr/local/bin/dot

### ruby package management
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$HOME/.rvm/gems/ruby-2.4.0/bin:$PATH"                                           # gems ruby
# export PATH="$HOME/.rvm/gems/ruby-2.4.0@global@/bin:$PATH"                                   # gems global ruby
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$HOME/.rvm/rubies/ruby-2.4.0/bin:$PATH"                                         # ruby

### node package management
export NVM_DIR="$HOME/.nvm"

### python package management
# added by Anaconda3 4.4.0 installer
export PATH="$PATH:$HOME/anaconda3/bin"

# postgres setting 
if [ ! -d /etc/paths.d ]; then
    sudo mkdir -p /etc/paths.d &&
    echo /Applications/Postgres.app/Contents/Versions/latest/bin | sudo tee /etc/paths.d/postgresapp
fi

# ----------------------------------------------
# custom alias
# ----------------------------------------------

# new key
alias c='clear'
alias l='ls'
alias srm='sudo rm -rf'
alias la='ls -la'
alias cdd='cd ~/Desktop'
alias cdp='cd ~/Desktop/my-code-project'
alias sysinfo='neofetch --config ~/.config/neofetch/config'
alias ui='ranger'
# git alias
alias git='hub'
alias g='git'
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gb='git branch'
alias gcm='git checkout master'
alias ge='git-extras'
alias gl='git log --oneline --graph --color --all --decorate'
alias gitex='source activate py35 && gitsome'
alias gitignore='git ignore-io'
# my dot template (https://github.com/kamontat/dot-github-mini)
alias dotgithub='~/.github/dotgithub'
# angular custom
alias ngg='git clone https://github.com/Template-Generating/angular-4-browser-sync.git'
# vim
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias vis="sudo nvim"
# rails 
alias r='rails'

# git ignore template
function gi() { 
  curl -L -s https://www.gitignore.io/api/$@ 
}
