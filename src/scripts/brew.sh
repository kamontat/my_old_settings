#!/usr/bin/env bash

# set -x #DEBUG - Display commands and their arguments as they are executed.
# set -v #VERBOSE - Display shell input lines as they are read.
# set -n #EVALUATE - Check syntax of the script but don't execute.

#/ -------------------------------------------------
#/ Title:        Homebrew script
#/ -------------------------------------------------
#/ Description:  This script will setting only dependencies of brew
#/               For install application in brew please see on '-p' option
#/               You can found list of dependencies on 'resource' folders
#/ Create by:    Kamontat Chantrachirathumrong
#/ Since:        10 Mar 2561
#/ -------------------------------------------------
#/ Version:      1.0.1  -- clean code
#/ -------------------------------------------------
#/ Bug:          no exist
#/ -------------------------------------------------

only_brew() {
    check_brew

    _load_multiple_dependencies

    validate_brew
    echo "$LIST_BREW_DEP"
    list_all_brew
}

# -------------------------------------------------
# Functions
# -------------------------------------------------

_load_multiple_dependencies() {
    loop_on_files "${RESOURCES_BREW}/dependencies/*.txt" "_load_brew_dependencies"
}

_load_brew_dependencies() {
    loop_show_library "$1" "brew_save_list" is_installed
    choose_as_pack "$2" brew_installation "${SHOWED_LIBRARYS[@]}"
}
