# maintain: Kamontat Chantrachirathumrong
# version:  1.2.1
# since:    11/06/1017

# added of bash prompt (vim) setting
[ -f $HOME/.shell_prompt.sh ] && source $HOME/.shell_prompt.sh
# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

[ -f "$HOME/.profile" ] && source $HOME/.profile
