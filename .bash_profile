# maintain: Kamontat Chantrachirathumrong
# version:  1.2.1
# since:    11/06/1017

# load profile
[ -s "$HOME/.profile" ] && source $HOME/.profile
# load bashrc
[ -s "$HOME/.bashrc" ] && source $HOME/.bashrc

# The theme color
# export CLICOLOR=1 
# export LSCOLORS=ExFxBxDxCxegedabagacad
# export PS1="\033[0;1;36m\u\033[0;1m:\033[1;103;30m\t\033[0m \033[1;92m\$\033[0m \r"

# testing iterm integration
test -e "$HOME/.iterm2_shell_integration.bash" && source $HOME/.iterm2_shell_integration.bash
