# history file

export HISTFILE=~/.zsh_history
export HIST_STAMPS="dd.mm.yyyy"
export HISTSIZE=100
export SAVEHIST=5000

# bind to vim key
bindkey -v

export EDITOR='vim'

# opt setting
setopt autocd beep extendedglob nomatch notify prompt_subst combining_chars
unsetopt appendhistory

# style setting
zstyle ':completion:*:descriptions' format $'%B%d%b' # blue color
zstyle ':completion:*:messages' format $'\e[00;31m%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

# zstyle ':completion:*:default' list-grouped true
zstyle ':completion:*' group-name ''
# zstyle ':completion:*:manuals' separate-sections true

# compinstall
autoload -Uz compinit
compinit

# completion
fpath=(/usr/local/bin/_NDD_FOLDER/completions $fpath)
compdef _ndd ndd
autoload -U _ndd
