export MY_ZSH="$HOME/.my-zsh"
export ZSH="$HOME/.oh-my-zsh"

test -s "$MY_ZSH/languages.zsh" && source $MY_ZSH/languages.zsh
test -s "$MY_ZSH/setting.zsh" && source $MY_ZSH/setting.zsh

# OH-MY-ZSH Setting

test -s "$ZSH/oh-my-zsh.sh" && source $ZSH/oh-my-zsh.sh
test -s "$MY_ZSH/ohmyzsh.zsh" && source "$MY_ZSH/ohmyzsh.zsh"

# My Zsh

test -s "$MY_ZSH/sourcing.zsh" && source "$MY_ZSH/sourcing.zsh"
test -s "$MY_ZSH/plugin.zsh" && source "$MY_ZSH/plugin.zsh"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
