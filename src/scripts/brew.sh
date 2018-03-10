#!/usr/bin/env bash

# set -x #DEBUG - Display commands and their arguments as they are executed.
# set -v #VERBOSE - Display shell input lines as they are read.
# set -n #EVALUATE - Check syntax of the script but don't execute.


#/ -------------------------------------------------
#/ Description:  This script will setting only dependencies of brew
#/               For install application in brew please see on '-p' option
#/               You can found list of dependencies on 'resource' folders
#/ Create by:    Kamontat Chantrachirathumrong
#/ Since:        10 Mar 2561
#/ -------------------------------------------------
#/ Version:      1.0.0  -- finish first version
#/ -------------------------------------------------
#/ Bug:          no exist
#/ -------------------------------------------------

only_brew() {
    check_brew

    _load_multiple_dependencies

    validate_brew
    echo "List all installed dependencies..."
    list_all_brew
}

# -------------------------------------------------
# Functions
# -------------------------------------------------

_load_multiple_dependencies() {
    local name 
    for file in $(ls ${RESOURCES_BREW}/dependencies/*.txt); do
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
        [ $e == $l ] && brew_install "$l" || brew_cask_install "$l"
    done
}
