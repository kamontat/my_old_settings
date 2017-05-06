#!/bin/bash

cd "$(dirname "$0")"

version=${BASH_VERSION:0:1}
printf "Bash version: $version, \nExpected: version [3|4]\n"

function replace_file {
    ans="Y"
    if [ -f $1 ]; then
        printf "exist: replace by ${1##/}? [Y|n]"
        read ans
    fi
    if [[ $ans == "Y" ]]; then
         cp $2 $1
         printf "replaced.\n"
    else
        printf "use old.\n"
    fi
}

function set_default_shell {
    str=""
    for shell in "${accept_shells[@]}" 
    do
        str="$str|${shell#/bin/}"
    done
    printf "set default shell[${str#|}|n]"
    read default_shell
    
    if [[ -f /bin/$default_shell ]]; then
        chsh -s /bin/$default_shell
        printf "default shell is ${SHELL#/bin/}\n"
    else 
        printf "current default shell is ${SHELL#/bin/}\n"
    fi
}

# -----------------------------------------------
# root
# -----------------------------------------------

# printf "run as administrator (suggest 'yes'): [Y|n]"
# read admin
# if [[ $admin == "Y" ]]; then 
#     sudo - 2> /dev/null
#     printf "run as administrator.\n"
# fi

# -----------------------------------------------
# global variable
# -----------------------------------------------

accept_shells=($(cat /etc/shells | grep -v "#"))

# -----------------------------------------------
# clone project
# -----------------------------------------------

replace_file ~/.bashrc ./.bashrc
replace_file ~/.bash_profile ./.bash_profile
replace_file ~/.profile ./.profile
# if zsh exist
if [[ -f /bin/zsh ]]; then
    replace_file ~/.zshrc ./.zshrc
fi

# -----------------------------------------------
# set shell
# -----------------------------------------------

set_default_shell

# -----------------------------------------------
# vim setting
# -----------------------------------------------


# -----------------------------------------------
# install everything
# -----------------------------------------------

# vim +PluginInstall +qall
