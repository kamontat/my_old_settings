#!/usr/bin/env bash

# set -x #DEBUG - Display commands and their arguments as they are executed.
# set -v #VERBOSE - Display shell input lines as they are read.
# set -n #EVALUATE - Check syntax of the script but don't execute.


#/ -------------------------------------------------
#/ Description:  ...
#/ Create by:    ...
#/ Since:        ...
#/ -------------------------------------------------
#/ Version:      0.0.1  -- description
#/               0.0.2b -- beta-format
#/ -------------------------------------------------
#/ Error code    1      -- error
#/ -------------------------------------------------
#/ Bug:          ...
#/ -------------------------------------------------


# -------------------------------------------------
# Functions
# -------------------------------------------------


# 0 - macOS
# 1 - Linux
# 2 - else
check_os() {
    os="$(uname)"
    [[ "$os" == "Darwin" ]] && echo 0 && return 0
    [[ "$os" == "Linux" ]] && echo 1 && return 0
    echo 2 && return 1
}

check_brew() {
    is_command_exist "brew" && echo "brew is installed" && return 0
    [ $(check_os) != 0 ] && return 1
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    run_brew tap caskroom/versions
    run_brew tap caskroom/fonts
}

check_user() {
    local user="$(who)"
    # ref: https://askubuntu.com/a/30157/8698
    # if [ "$(id -u)" -ne 0 ]; then
    if [ $user != "root" ]; then
        echo "run as $user! ->
    I suggest you to run as root by add 'sudo' to the front of index"
        printf "Do you sure? [Y|n] "
        read -rn 1 ans
        [[ $ans == "n" ]] && echo && exit 1 || echo
    else
        echo "Run as Administrator!"
        # echo "Shouldn't run as 'root' at default"
        # exit 1
    fi
}