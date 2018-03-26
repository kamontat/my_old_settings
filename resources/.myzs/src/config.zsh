#/ # Configuration file
#/ # List of knowledge
#/ 1. MYZS - my zsh settings
#/ 2. Kc - Kamontat Chantrachirathumrong (Creator and developer)

export USER="kamontat"
export EDITOR='nvim'
export VISUAL='nvim'

# Open debug mode will log almost every action in the script
export MYZS_DEBUG=false
# NOT implement YET!
export MYZS_VERBOSE=true

# Are you developer?
export MYZS_IS_DEVELOPER=true

# Do you use 'git'
export MYZS_USE_GIT=true
# Do you use 'gitmoji'
export MYZS_USE_GITMOJI=true
# Do you use 'node'
export MYZS_USE_NODE=true
# Do you use 'java'
export MYZS_USE_JAVA=true
# Do you use 'android'
export MYZS_USE_ANDROID=true
# Do you use 'python'
export MYZS_USE_PYTHON=true
# Do you use 'ruby'
export MYZS_USE_RUBY=true
# Do you use 'docker'
export MYZS_USE_DOCKER=true
# Do you use 'iterm'
export MYZS_USE_ITERM=true

# Do you use 'wakatime'
export MYZS_USE_WAKA=true

# Do you use 'utils pack'
# 1. 'wd' -> jump to point directory
# 2. 'calc' -> simple zsh calculator
# 3. 'fasd' -> offers quick access to files and directories (DISABLE)
# 4. 'web-search' -> searching thing in internet, exp: 'google hello'
export MYZS_USE_UTIL=true

# auto correct wrong command
export MYZS_USE_CORRECTION=true

# zplug home, comment if you don't use
export ZPLUG_HOME=/usr/local/opt/zplug

# [[ $MYZS_VERBOSE == true ]] && set -x
