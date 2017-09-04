#!/bin/bash
set -e
cd "$(dirname "$0")"

source ./resource/color_raw_constants.sh

# variable init
shell=""
user=$(whoami)
admin=""
pass=""

force_yes=false

# option
while getopts 'AYs:u:h' flag; do
  case "${flag}" in
    A) admin="Y" ;;
    Y) force_yes=true ;;
    s) shell=$OPTARG ;;
    u) user=$OPTARG ;;
    h) printf "available option \n\t$RED \bA$RESET - run as admin\n\t$RED \bY$RESET - always say 'yes'\n\t$RED \bs<SHELL>$RESET - default shell\n\t$RED \bu<USER>$RESET - user of shell\n" && exit 0 ;;
    *) error "Unexpected option ${flag} run -h for more information" ;;
  esac
done

version=${BASH_VERSION:0:1}
printf "Bash version: $version, \nExpected: version [3|4]\n"
echo ""

# function
function copy {
    if [[ $pass != "" ]]; then
        echo "$pass" | sudo -S cp -rf $1 $2
    else 
        # save cache if file exist
        if [[ -f $2 ]] || [[ -d $2 ]]; then
            cp -rf $2 $2.cache
        fi
        # copy
        cp -rf $1 $2
    fi
}

function replace {
    # force copy
    if $force_yes; then
        copy $1 $2 && printf "${RED}force${RESET} replace $2\n"
    else 
        # is exist
        if [ -f $1 ]; then
            printf "${RED}exist${RESET}: Do you want to replace $2? [Y(es)|n(o)|S(how)] "
            read -n 1 ans
            echo "" # new line
            # replace 
            if [[ $ans == "Y" ]] || [[ $ans == "yes" ]] || [[ $ans == "y" ]] || [[ $ans == "Yes" ]]; then
                copy $1 $2
                printf "replaced ($1 -> $2).\n"
            # not replace
            elif [[ $ans == "S" ]] || [[ $ans == "show" ]] || [[ $ans == "s" ]] || [[ $ans == "Show" ]]; then
                printf "$BLUE$(cat $1)$RESET\n"
                replace $1 $2 
            else 
                printf "used old $1.\n"
            fi
        # not exist
        else
            copy $1 $2
            printf "copy to $1.\n"
        fi
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
        printf "changeing default shell to $shell\nTo save change you need to restart your computer"
        return 0 # true
    else 
        printf "current default shell is $SHELL\n"
    fi
}

function install_fonts {
    if [ -d fonts ]; then 
        rm -rf fonts 
    fi
    git clone https://github.com/powerline/fonts.git fonts &&
    cd fonts &&
    ./install.sh &&
    cd .. &&
    rm -rf fonts
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
    echo ""
    printf "run as administrator.\n"
fi

# -----------------------------------------------
# global variable
# -----------------------------------------------

accept_shells=($(cat /etc/shells | grep -v "#"))

# -----------------------------------------------
# clone project
# -----------------------------------------------
echo ""
printf "Starting clone project... \n"

printf "\nInstall '.bashrc' contain 'travis setting' and 'bash prompt (vim) setting' \n"
replace ./.bashrc ~/.bashrc 
printf "\nInstall '.bash_profile' contain 'bash loader' and 'iterm integration'\n"
replace ./.bash_profile ~/.bash_profile 
printf "\nInstall '.profile' contain 'all export constants' and 'alias (shortcut key)'\n"
replace ./.profile ~/.profile 
printf "\nInstall '.vimrc' contain 'plugin install' and 'vim setting' (cannot show!!)\n"
replace ./.vimrc ~/.vimrc 
printf "\nInstall '.tmux.conf' contain 'tmux configuration (cannot show!!)'\n"
replace ./.tmux.conf ~/.tmux.conf 

[ -f /bin/zsh ] && printf "\nInstall '.zshrc' contain 'zsh script config' and 'vim setting'\n" && replace ./.zshrc ~/.zshrc 
[ -f /bin/zsh ] && printf "\nInstall '.zsh' contain 'zsh plugin'\n" && replace ./.zsh ~/.zsh

# -----------------------------------------------
# set shell
# -----------------------------------------------

echo ""
set_default_shell

# -----------------------------------------------
# vim setting
# -----------------------------------------------



# -----------------------------------------------
# install everything
# -----------------------------------------------
echo ""
printf "\nStarting install... \n"
printf "Starting install fonts..\n"
install_fonts 

echo ""
printf "Starting install vim plugin.. (ignore the error at first time)\n"
vim +PluginInstall +qall

echo ""
printf "Starting create promeline..\n"
vim -c ":PromptlineSnapshot! ~/.shell_prompt.sh airline" -c ":q"

echo ""
printf "Loading newest SHELL setting\n"
source ~/.bash_profile
[ -f /bin/zsh ] && zsh && source ~/.zshrc

# -----------------------------------------------
# extra help
# -----------------------------------------------

echo ""
printf "The fonts of this setting is 'DefaVu Sans Mono for Powerline' "
printf "set on your terminal.\n"

printf "you must change your name in '.profile' at line 5\n"
printf "the terminal might return the error out at the first time, so you can ignore it!\n"
printf "But if you run vim and still error, issue to me at (https://github.com/kamontat/my_vim/issues)\n"

# printf "some plugin need extra install, so see more in '~/.vimrc' file.\n"

printf "Thank you for loading my vim setting.\n"
printf "\tcreate by 'Kamontat Chantrachirathumrong.\n"