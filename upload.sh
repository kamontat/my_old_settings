#!/bin/bash
set -e
cd "$(dirname "$0")"

# function
function copy {
    if [[ $pass != "" ]]; then
        echo "$pass" | sudo -S cp -rf $1 $2
    else 
        cp -rf $1 $2
    fi
}

if [[ $admin == "" ]]; then
    printf "run as administrator (suggest 'yes'): [Y|n]"
    read -n 1 admin
    echo ""
fi
if [[ $admin == "Y" ]]; then 
    printf "Enter administrator password: "
    read -s pass
    echo ""
    printf "run as administrator.\n"
fi

# -----------------------------------------------
# save project
# -----------------------------------------------

copy ~/.bashrc ./.bashrc 
copy ~/.bash_profile ./.bash_profile 
copy ~/.profile ./.profile 
copy ~/.vimrc ./.vimrc 
copy ./.zshrc ~/.zshrc 
copy ./.zsh ~/.zsh

# -----------------------------------------------
# extra help
# -----------------------------------------------

echo "complete -- log at 'out.log'"

echo $(date) >> out.log
