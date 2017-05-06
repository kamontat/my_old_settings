#!/bin/bash
set -e
cd "$(dirname "$0")"

# variable init
shell=""
user=$(whoami)
admin=""
pass=""

# option
while getopts 'AYs:u:h' flag; do
  case "${flag}" in
    A) admin="Y" ;;
    Y) ans="Y" ;;
    s) shell=$OPTARG ;;
    u) user=$OPTARG ;;
    h) printf "available option \n\tA - run as admin\n\tY - always say 'yes'\n\ts - default shell\n\tu - user of shell" && exit 0 ;;
    *) error "Unexpected option ${flag} run -h for more information" ;;
  esac
done

version=${BASH_VERSION:0:1}
printf "Bash version: $version, \nExpected: version [3|4]\n"

# function
function replace_file {
    if copy_by_ans $2 $1; then
        printf "replaced ($1 -> $2).\n"
        return
    fi
    if [ -f $1 ]; then
        printf "exist: replace by $2? [Y|n]"
        read -n 1 ans
        echo "" # new line
    fi

    if copy_by_ans $2 $1; then
        printf "replaced ($1 -> $2).\n"
        ans=""
    else 
        printf "used old one.\n"
    fi
}

function copy_by_ans {
    if [[ $ans == "Y" ]]; then
        if [[ $pass != "" ]]; then
            echo "$pass" | sudo -S cp $1 $2
        else 
            cp $1 $2
        fi
         return 0
    else
        return 1
    fi
}

function set_default_shell {
    if [[ shell != "" ]]; then 
        if set_shell $shell; then 
            return
        fi
    fi
    str=""
    for shell in "${accept_shells[@]}" 
    do
        str="$str|${shell#/bin/}"
    done
    printf "set default shell[${str#|}|n]"
    read shell
    set_shell $shell
}

function set_shell {
    if [[ -f /bin/$1 ]]; then
        if [[ $pass != "" ]]; then
            echo "$pass" | sudo -S chsh -s /bin/$1 $user
        else 
            chsh -s /bin/$1 $user
        fi
        printf "default shell is $shell\n"
        return 0 # true
    else 
        printf "current default shell is $shell\n"
        return 1 # false
    fi
}

# -----------------------------------------------
# root
# -----------------------------------------------

if [[ $admin == "" ]]; then
    printf "run as administrator (suggest 'yes'): [Y|n]"
    read -n 1 admin
    echo ""
fi
if [[ $admin == "Y" ]]; then 
    printf "Enter administrator password: "
    read -s pass
    printf "run as administrator.\n"
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
