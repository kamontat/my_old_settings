# This plugin using zplug

export ZPLUG_HOME=/usr/local/opt/zplug

_oh_my_zsh_lib() {
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
    zplug 'lib/theme-and-appearance', from:oh-my-zsh
}

_oh_my_zsh_plug() {
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
    zplug "plugins/wd", from:oh-my-zsh
    zplug "plugins/calc", from:oh-my-zsh
}

_zsh_user_plug() {
    zplug "zsh-users/zsh-syntax-highlighting", defer:2
    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-completions"
    zplug "zsh-users/zsh-history-substring-search"
}

_other_plug() {
    zplug "b4b4r07/emoji-cli"
    zplug "unixorn/tumult.plugin.zsh"
    zplug "peterhurford/up.zsh"
}

install_plugin_zplug() {
    zplug 'zplug/zplug', hook-build:'zplug --self-manage'

    _oh_my_zsh_lib
    _oh_my_zsh_plug
    _zsh_user_plug
    _other_plug
}

install_theme_zplug() {
    zplug "denysdovhan/spaceship-zsh-theme", use:spaceship.zsh, from:github, as:theme
    _theme_config
}

_theme_config() {
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
    SPACESHIP_TIME_FORMAT="%D{%d-%m-%Y %H.%M.%S}"
    SPACESHIP_BATTERY_ALWAYS_SHOW=true
    SPACESHIP_EXIT_CODE_SHOW=true
}

if test -d "$ZPLUG_HOME"; then
    source $ZPLUG_HOME/init.zsh

    install_plugin_zplug
    install_theme_zplug

    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo
            zplug install
        fi
    fi

    zplug load
else
    echo "NO ZPLUG INSTALLED"
fi
