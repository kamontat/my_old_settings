# maintain: Kamontat Chantrachirathumrong
# version:  1.2.1
# since:    11/06/1017

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source $HOME/.rvm/scripts/rvm

# set default variable
export USER="kamontat"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

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
# custom path
# set python3 location
# export PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:$PATH"                    # python version 3.5
# set rvm, ruby, gems location
# export PATH="$HOME/.rvm/gems/ruby-2.4.0/bin:$PATH"                                           # gems ruby
# export PATH="$HOME/.rvm/gems/ruby-2.4.0@global@/bin:$PATH"                                   # gems global ruby
export PATH="/usr/local/opt/openssl/bin:$PATH"                                               # openssl
# export PATH="$HOME/.rvm/rubies/ruby-2.4.0/bin:$PATH"                                         # ruby
# java home setting
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home"          # java home
export PATH="$JAVA_HOME/bin:$PATH"                                                     	     # java path

export ANDROID_HOME="~/Library/Android/sdk"                                                  # android home
export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"                         # android path

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$HOME/.rvm/gems/ruby-2.4.1/bin:$PATH"

export GRAPHVIZ_DOT=/usr/local/bin/dot

export NVM_DIR="$HOME/.nvm"

if [ ! -d /etc/paths.d ]; then
    sudo mkdir -p /etc/paths.d &&
    echo /Applications/Postgres.app/Contents/Versions/latest/bin | sudo tee /etc/paths.d/postgresapp
fi

# custom alias
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
alias g='git'
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gb='git branch'
alias gcm='git checkout master'
alias ge='git-extras'
# angular custom
alias ngg='git clone https://github.com/Template-Generating/angular-4-browser-sync.git'
alias v='vim'
alias r='rails'
