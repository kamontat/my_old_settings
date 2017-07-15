#!/bin/bash
set -e
cd "$(dirname "$0")"

echo "starting uninstall script !!"

function remove {
    rm -rf $1
    load_cache $1
}

# load cache file, if cache not exist create new one!
function load_cache {
    -d $1.cache || -f $1.cache && mv $1.cache $1 || echo "$1 don't have cache file"
}

remove ~/.shell_prompt.sh

remove ~/.bash_profile

remove ~/.bashrc

remove ~/.profile

remove ~/.tmux.conf

remove ~/.vimrc

remove ~/.zsh

remove ~/.zshrc
