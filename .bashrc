# maintain: Kamontat Chantrachirathumrong
# version:  1.2.1
# since:    11/06/1017

# tmux; # automatic go in to tmux # tmux is for zsh shell

# new key setting

# added travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh
# added of bash prompt (vim) setting
[ -f $HOME/.shell_prompt.sh ] && source $HOME/.shell_prompt.sh
# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# clear

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
