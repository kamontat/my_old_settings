#!/bin/bash

cd "$(dirname "$0")"

function replace_file {
    ans="Y"
    if [ -f $1 ]; then
        echo "exist: install new $1? [Y|n]"
        read ans
    fi
    if [[ $ans == "Y" ]]; then
         cp $2 $1
         echo "replaced."
    else
        echo "use old."
    fi
}

function set_default_shell {
    # ${VAR#/bin/}
    echo "${accept_shells[@]}"
    

    echo "set default shell[bash|zsh|fish|...]"
    
    read default_shell
    
    if [[ -f /bin/$default_shell ]]; then
        chsh -s /bin/$default_shell
        echo "default shell is $SHELL"
    fi
}


# -----------------------------------------------
# root
# -----------------------------------------------

echo "run as administrator (suggest 'yes'): [Y|n]"
read admin
if [[ $admin == "Y" ]]; then 
    sudo - 2> /dev/null
    echo "run as administrator."
fi

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
