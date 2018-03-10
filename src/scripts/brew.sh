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

only_brew() {
    check_brew

    _load_multiple_dependencies

    validate_brew
    echo "List all installed dependencies..."
    list_brew
}

_load_multiple_dependencies() {
    local name 
    for file in $(ls ${RESOURCES_OTH}/brew/*.txt); do
        name="${file##*/}"
        name="${name%%.*}"
        _load_brew_dependencies "$file" "$name"
    done
}

_load_brew_dependencies() {
    local line file="$1" arr=()
    local lib detail i=0

    while IFS='' read -r line || [[ -n "$line" ]]; do
        i="$((i + 1))"
        lib="${line%%=*}"
        detail="${line##*=}"
        printf "%3d) %-20s - %s\n" "$i" "${lib##* }" "$detail"
        arr+=("$lib")
    done < "$file"

    choose "'$2' library" && _brew_installation "${arr[@]}"
}

_brew_installation() {
    for lib in "$@"; do
        e="${lib%% *}"
        l="${lib##* }"
        [ $e == $l ] && _brew_install "$l" || _brew_cask_install "$l"
    done
}

_brew_install() {
    run_brew install "$1"
}

_brew_cask_install() {
    run_brew cask install "$1"
}

validate_brew() {
    run_brew doctor
}

list_brew() {
    run_brew list
}
