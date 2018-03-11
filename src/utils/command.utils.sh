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
# BREW Functions
# -------------------------------------------------

run_brew() {
    [ "$user" == "root" ] || [ "$user" == "" ] && throw "To run brew, you must input username (-u <name>)" 1
    sudo -u "$user" brew "$@"
}

run_brew_cask() {
    run_brew cask "$@"
}

brew_install() {
    run_brew install "$@"
}

brew_cask_install() {
    run_brew_cask install "$@"
}

validate_brew() {
    run_brew doctor
    run_brew_cask doctor
}

list_all_brew() {
    list_brew
    list_cask_brew
}

list_brew() {
    run_brew list
}

list_cask_brew() {
    run_brew_cask list
}

brew_save_list() {
    export BREW_LIST="$(list_brew)"
    export BREW_CASK_LIST="$(list_cask_brew)"
}

is_installed() {
    [ -z "$BREW_LIST" ] && export BREW_LIST="$(list_brew)"
    echo "$BREW_LIST" | grep -q "$1"
}

is_cask_installed() {
    [ -z "$BREW_CASK_LIST" ] && export BREW_CASK_LIST="$(list_cask_brew)"
    echo "$BREW_CASK_LIST" | grep -q "$1"
}

# -------------------------------------------------
# <> Functions
# -------------------------------------------------