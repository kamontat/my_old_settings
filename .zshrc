# maintain: Kamontat Chantrachirathumrong
# version:  1.2.0
# since:    03/05/2017

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey -v
zstyle :compinstall filename '$HOME/.zshrc'

# export LS_COLORS='no=00;37:fi=00:di=00;33:ln=04;36:pi=40;33:so=01;35:bd=40;33;01:'
export CLICOLOR=1
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # set color

export TERM='xterm-256color'
autoload -Uz compinit
compinit
# End of lines added by compinstall

[[ -s "$HOME/.profile" ]] && source ~/.profile

source $HOME/.shell_prompt.sh
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# tmux; clear # auto into tmux

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
