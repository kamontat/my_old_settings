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
    loop_on_files "${RESOURCES_BREW}/dependencies/*.txt" "_load_brew_dependencies"
}

_load_brew_dependencies() {
    local line file="$1" arr=()
    local lib detail i=0

    brew_save_list
    while IFS='' read -r line || [[ -n "$line" ]]; do
        i="$((i + 1))"
        lib="${line%%=*}"
        detail="${line##*=}"

        is_installed "$lib" && installed="I" || installed="N"
        printf "%3d) %-20s (%s) - %s\n" "$i" "${lib##* }" "$installed" "$detail"
        arr+=("$lib")
    done < "$file"

    choose "'$2' library" && brew_installation "${arr[@]}"
}
