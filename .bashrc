export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH=/usr/local/git/bin:/usr/local/sbin:/Library/Frameworks/Python.framework/Versions/3.5/bin:/Library/Frameworks/Python.framework/Versions/3.5/bin:/Users/kamontat/Framework/cocos2d-x-3.11/templates:/Users/kamontat/Framework:/Users/kamontat/Framework/cocos2d-x-3.11/tools/cocos2d-console/bin:/Users/kamontat/.rvm/gems/ruby-2.2.1/bin:/Users/kamontat/.rvm/gems/ruby-2.2.1@global/bin:/Users/kamontat/.rvm/rubies/ruby-2.2.1/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/kamontat/.rvm/bin
# java home setting
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_121.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH 

# newest version of vim by homebrew
alias vim='/usr/local/Cellar/vim/8.0.0589/bin/vim'
alias c='clear'
alias srm='sudo rm -rf'

# added travis gem
[ -f /Users/kamontat/.travis/travis.sh ] && source /Users/kamontat/.travis/travis.sh
# added of bash prompt (vim) setting
[ -f ~/.shell_prompt.sh ] && source /Users/kamontat/.shell_prompt.sh
