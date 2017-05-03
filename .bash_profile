tmux ;
clear ;
source ~/.bashrc ;
clear ;

echo "Welcome, To My Program" ;
pwd

export USER="Kamontat"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8


# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s "~/.bashrc" ]] && source ~/.bashrc # 

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT=/Users/kamontat/Framework/cocos2d-x-3.11/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable COCOS_X_ROOT for cocos2d-x
export COCOS_X_ROOT=/Users/kamontat/Framework
export PATH=$COCOS_X_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
export COCOS_TEMPLATES_ROOT=/Users/kamontat/Framework/cocos2d-x-3.11/templates
export PATH=$COCOS_TEMPLATES_ROOT:$PATH

# Setting PATH for Python 3.5
# The orginal version is saved in .bash_profile.pysave
export PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"

export PATH=/usr/local/bin:/Library/Frameworks/Python.framework/Versions/3.5/bin:/Library/Frameworks/Python.framework/Versions/3.5/bin:/Users/kamontat/Framework/cocos2d-x-3.11/templates:/Users/kamontat/Framework:/Users/kamontat/Framework/cocos2d-x-3.11/tools/cocos2d-console/bin:/Users/kamontat/.rvm/gems/ruby-2.2.1/bin:/Users/kamontat/.rvm/gems/ruby-2.2.1@global/bin:/Users/kamontat/.rvm/rubies/ruby-2.2.1/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/kamontat/.rvm/bin

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1 
export LSCOLORS=ExFxBxDxCxegedabagacad

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
