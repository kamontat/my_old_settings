#!/bin/bash
set -e

cd "$(dirname "$0")"

# -------------------------------------------------
# Constants
# -------------------------------------------------

accept_shells=($(grep -v "#" </etc/shells))
cache_postfix="my_setting_cache"

# -------------------------------------------------
# Variables
# -------------------------------------------------

shell=""
user=$(whoami)

always_yes=false

# -------------------------------------------------
# Prompt
# -------------------------------------------------

# ref: https://askubuntu.com/a/30157/8698
if [ "$(id -u)" -ne 0 ]; then
    echo "run as $user! -> 
    I suggest you to run as root by add 'sudo ./install.sh'"
    printf "Do you sure? [y|n] "
    read -rn 1 ans
    [[ $ans == "n" ]] && exit 1
else
    echo "run as Administrator!"
fi

# -------------------------------------------------
# Functions
# -------------------------------------------------

# @explain    - exit non zero code with message
# @params - 1 - error message
#           2 - error code
throw() {
    printf "%s\n" "$1" && exit $2
}

# @explain    - exit non zero code if long opt value is empty
# @require    - throw method in helper_api
# @params - 1 - error message
#           2 - error code
# @return     - message and code handle by $?
throw_if_empty() {
    [ -n "$LONG_OPTVAL" ] && return 0 || throw "$1" $2
}

# @explain    - get key and value automatially
# @require    - use in `getopts` only
set_key_value_long_option() {
    if [[ $OPTARG =~ "=" ]]; then
        LONG_OPTVAL="${OPTARG#*=}"
        LONG_OPTARG="${OPTARG%=$LONG_OPTVAL}"
    else
        LONG_OPTARG="$OPTARG"
        LONG_OPTVAL="$NEXT_PARAMS"
        OPTIND=$((OPTIND + 1))
    fi
}

# @explain    - get key and value automatially
# @require    - use in `getopts` only
require_argument() {
    throw_if_empty "'$LONG_OPTARG' require argument" 9
}

no_argument() {
    OPTIND=$((OPTIND - 1))
}

# @explain    - copy file to other location
# @params - 1 - file or folder
#           2 - output location
copy() {
    cp -rf "$1" "$2"
}

# @explain    - save cache (as DayMonthYearHour)
# @params - 1 - file or folder
cache() {
    copy "$1" "$1.$(date +%d%m%y%H).$cache_postfix"
}

# @explain    - try to move setting file to location
# @params - 1 - setting file / folder
#           2 - result location
move_setting() {
    file="$1"
    result="$2"
    [ -d "$result" ] && result="$result/${file##*/}"

    # force copy
    if $always_yes; then
        cache "$result" &&
            copy "$file" "$result" &&
            echo "${C_FG_1}force${C_RE_AL} replace $result" || return $?
        return 0
    fi

    # copy
    if [ ! -f "$result" ]; then
        copy "$file" "$result" && echo "${C_FG_1}copy${C_RE_AL} $file -> $result" || return $?
        return 0
    fi
    # replace
    printf "%s ${C_FG_1}exist!${C_RE_AL} -> Do you want to replace %s?\n [y(es)|n(o)|s(how)] " "$file" "$result"
    read -rn 1 ans
    echo "" # new line
    # replace
    if [[ $ans == "y" ]]; then
        cache "$result" &&
            copy "$file" "$result" &&
            echo "${C_FG_1}replaced${C_RE_AL} ($file -> $result)" || return $?
        # not replace
    elif [[ $ans == "s" ]]; then
        echo 'start """ '
        cat "$file" && echo ""
        echo '""" end.'
        move_setting "$file" "$result"
    else
        echo "use ${C_FG_1}old${C_RE_AL} file ($result)"
    fi
}

set_default_shell() {
    if [[ shell != "" ]]; then
        if set_shell $shell; then
            return
        fi
    fi
    str=""
    for shell in "${accept_shells[@]}"; do
        str="$str|${shell#/bin/}"
    done
    printf "set default shell[${str#|}|n]"
    read shell
    set_shell $shell
}

set_shell() {
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

install_fonts() {
    if [ -d fonts ]; then
        rm -rf fonts
    fi
    git clone https://github.com/powerline/fonts.git fonts &&
        cd fonts &&
        ./install.sh &&
        cd .. &&
        rm -rf fonts
}

# -------------------------------------------------
# Application
# -------------------------------------------------

# option
while getopts 'YCs:u:h-:' flag; do
    case "${flag}" in
        Y) always_yes=true ;;
        C) source ./color.sh true ;;
        s) shell=$OPTARG ;;
        u) user=$OPTARG ;;
        h)
            echo "
./install.sh [C] [A|Y|[s<SHELL>|u<USER>]] [h]

Available option:
    ${C_FG_1}-${C_UL}Y${C_RE_UL}        | --${C_UL}yes${C_RE_AL}           - always say 'yes'
    ${C_FG_1}-${C_UL}C${C_RE_UL}        | --${C_UL}color${C_RE_AL}         - add color
    ${C_FG_1}-${C_UL}s<SHELL>${C_RE_UL} | --${C_UL}shell=<SHELL>${C_RE_AL} - input default shell
    ${C_FG_1}-${C_UL}u<USER>${C_RE_UL}  | --${C_UL}user=<USER>${C_RE_AL}   - input default user
"
            exit 0
            ;;
        -)
            LONG_OPTARG=
            LONG_OPTVAL=
            NEXT_PARAMS="${!OPTIND}" # OPTIND -> pointer to next parameter
            set_key_value_long_option
            case "${OPTARG}" in
                yes*)
                    no_argument
                    always_yes=true
                    ;;
                color*)
                    no_argument
                    source ./color.sh true
                    ;;
                shell*)
                    require_argument
                    shell="$LONG_OPTVAL"
                    ;;
                user*)
                    require_argument
                    user="$LONG_OPTVAL"
                    ;;
                *)
                    if [ "$OPTERR" = 1 ] && [ "${optspec:0:1}" != ":" ]; then
                        echo "Unexpected option '$LONG_OPTARG', run -h for more information"
                        exit 9
                    fi
                    ;;
            esac
            ;;
        *) echo "Unexpected option ${flag} run -h for more information" >&2 ;;
    esac
done

# Usage

# move_setting ./file1 ~/location

# -----------------------------------------------
# clone project
# -----------------------------------------------
# echo ""
# printf "Starting clone project... \n"

# printf "\nInstall '.bashrc' contain 'travis setting' and 'bash prompt (vim) setting' \n"
# replace ./.bashrc ~/.bashrc
# printf "\nInstall '.bash_profile' contain 'bash loader' and 'iterm integration'\n"
# replace ./.bash_profile ~/.bash_profile
# printf "\nInstall '.profile' contain 'all export constants' and 'alias (shortcut key)'\n"
# replace ./.profile ~/.profile
# printf "\nInstall '.vimrc' contain 'plugin install' and 'vim setting' (cannot show!!)\n"
# replace ./.vimrc ~/.vimrc
# printf "\nInstall '.tmux.conf' contain 'tmux configuration (cannot show!!)'\n"
# replace ./.tmux.conf ~/.tmux.conf

# [ -f /bin/zsh ] && printf "\nInstall '.zshrc' contain 'zsh script config' and 'vim setting'\n" && replace ./.zshrc ~/.zshrc
# [ -f /bin/zsh ] && printf "\nInstall '.zsh' contain 'zsh plugin'\n" && replace ./.zsh ~/.zsh

# -----------------------------------------------
# set shell
# -----------------------------------------------

# echo ""
# set_default_shell

# -----------------------------------------------
# vim setting
# -----------------------------------------------

# -----------------------------------------------
# install everything
# -----------------------------------------------
# echo ""
# printf "\nStarting install... \n"
# printf "Starting install fonts..\n"
# install_fonts

# echo ""
# printf "Starting install vim plugin.. (ignore the error at first time)\n"
# vim +PluginInstall +qall

# echo ""
# printf "Starting create promeline..\n"
# vim -c ":PromptlineSnapshot! ~/.shell_prompt.sh airline" -c ":q"

# echo ""
# printf "Loading newest SHELL setting\n"
# source ~/.bash_profile
# [ -f /bin/zsh ] && zsh && source ~/.zshrc

# -----------------------------------------------
# extra help
# -----------------------------------------------

# echo ""
# printf "The fonts of this setting is 'DefaVu Sans Mono for Powerline' "
# printf "set on your terminal.\n"

# printf "you must change your name in '.profile' at line 5\n"
# printf "the terminal might return the error out at the first time, so you can ignore it!\n"
# printf "But if you run vim and still error, issue to me at (https://github.com/kamontat/my_vim/issues)\n"

# printf "some plugin need extra install, so see more in '~/.vimrc' file.\n"

# printf "Thank you for loading my vim setting.\n"
# printf "\tcreate by 'Kamontat Chantrachirathumrong.\n"
