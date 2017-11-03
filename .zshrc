bindkey -v

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/kamontat/.oh-my-zsh
# Make sure prompt is able to be generated properly.
setopt prompt_subst

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags

source $ZSH/oh-my-zsh.sh

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Enable ZSH's Plugin Manager.
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# ZPlug's plugin to let it manage itself.
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Libraries from oh-my-zsh
zplug 'lib/bzr', from:oh-my-zsh
zplug 'lib/clipboard', from:oh-my-zsh
zplug 'lib/compfix', from:oh-my-zsh
zplug 'lib/completion', from:oh-my-zsh
zplug 'lib/correction', from:oh-my-zsh
zplug 'lib/diagnostics', from:oh-my-zsh
zplug 'lib/directories', from:oh-my-zsh
zplug 'lib/functions', from:oh-my-zsh
zplug 'lib/git', from:oh-my-zsh
zplug 'lib/grep', from:oh-my-zsh
zplug 'lib/history', from:oh-my-zsh
zplug 'lib/key-bindings', from:oh-my-zsh
zplug 'lib/misc', from:oh-my-zsh
zplug 'lib/nvm', from:oh-my-zsh
zplug 'lib/prompt_info_function', from:oh-my-zsh
zplug 'lib/spectrum', from:oh-my-zsh
zplug 'lib/termsupport', from:oh-my-zsh
zplug 'lib/theme-and-appearance', from:oh-my-zsh # This will `setopt autocd` for us

# Plugins from oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/git-extras", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/nyan", from:oh-my-zsh
zplug "plugins/redis-cli", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/systemd", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh
zplug "plugins/tmuxinator", from:oh-my-zsh
zplug "plugins/urltools", from:oh-my-zsh
zplug "plugins/web-search", from:oh-my-zsh
zplug "plugins/yarn", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/fasd", from:oh-my-zsh

# Custom Plugins
zplug "b4b4r07/emoji-cli"
zplug 'mfaerevaag/wd'
zplug "unixorn/tumult.plugin.zsh"
zplug "arzzen/calc.plugin.zsh"
zplug "peterhurford/up.zsh"

# Awesome Plugins for Syntax Highlighting, Autosuggestions, and Shell Completions
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"

# Theme 1
# zplug "eendroroy/alien", as:theme
# Theme 2 
# zplug "caiogondim/bullet-train.zsh", use:bullet-train.zsh-theme, defer:3 
# BULLETTRAIN_STATUS_EXIT_SHOW=true
# Theme 3
zplug denysdovhan/spaceship-zsh-theme, use:spaceship.zsh, from:github, as:theme

# vi_mode
SPACESHIP_PROMPT_ORDER=(
  time
  user
  host
  hg
  package
  node
  ruby
  elixir
  xcode
  swift
  golang
  php
  rust
  julia
  docker
  aws
  venv
  conda
  pyenv
  dotnet
  ember
  line_sep
  dir
  git
  exec_time
  line_sep
  battery
  exit_code
  jobs
  char
)

SPACESHIP_TIME_SHOW=true
SPACESHIP_BATTERY_ALWAYS_SHOW=true
SPACESHIP_EXIT_CODE_SHOW=true

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

[ -s "$HOME/.profile" ] && source $HOME/.profile
