#!/usr/bin/env bash

# set -x #DEBUG - Display commands and their arguments as they are executed.
# set -v #VERBOSE - Display shell input lines as they are read.
# set -n #EVALUATE - Check syntax of the script but don't execute.


# -------------------------------------------------
# Description:  ...
# Create by:    ...
# Since:        ...
# -------------------------------------------------
# Version:      0.0.1  -- description
#               0.0.2b -- beta-format
# -------------------------------------------------
# Error code    1      -- error
# -------------------------------------------------
# Bug:          ...
# -------------------------------------------------


# -------------------------------------------------
# Functions
# -------------------------------------------------

check_volume() {
    ls /Volumes
}

reset() {
    unset MOUNT_VOLUME
}

mount_dmg() {
    local o
    o="$(create_temp_folder)"
    hdiutil attach -mountpoint "$o" "$1" >/dev/null
    export MOUNT_VOLUME="$o"
}

unmount_dmg() {
    [ -z "$MOUNT_VOLUME" ] && export MOUNT_VOLUME="$1"
    hdiutil detach "$MOUNT_VOLUME" >/dev/null
}

install_dmg() {
    local app pkg
    [ -z "$MOUNT_VOLUME" ] && export MOUNT_VOLUME="$1"

    app="$(ls -1 "$MOUNT_VOLUME" | grep ".app")"
    pkg="$(ls -1 "$MOUNT_VOLUME" | grep ".pkg")"

    echo "app call -> $app"
    echo "pkg call -> $pkg"
    
    if [[ "$app" != "" ]]; then
        _copy_if_app "${MOUNT_VOLUME}/${app}"
    elif [[ "$pkg" != "" ]]; then
        _copy_if_pkg "${MOUNT_VOLUME}/${pkg}"
    else
        throw "unknown application format @$MOUNT_VOLUME"
    fi
}

_copy_if_app() {
    local app="$1"
    sudo cp -R "$app" "/Applications" || throw "cannot install app {$app}"
}

_copy_if_pkg() {
    local pkg="$1"
    sudo installer -pkg "$pkg" -target "$(get_harddrive_name)"
}

loop_on_files() {
    local files="$1" command="$2" name file
    for file in $(ls $files); do
        name="${file##*/}"
        name="${name%%.*}"
        "$command" "$file" "$name"
    done
}

loop_show_library() {
    local file="$1" pre_cmd="$2" check_cmd="$3" include_minus="$4" # post_cmd="$4" 
    local line i lib detail installed

    export SHOWED_LIBRARYS=()

    "$pre_cmd"

    [[ $include_minus == true ]] && 
        printf "$DISPLAY_LIBRARY_FORMAT" -1 "$NONE" " " "$NOT_INSTALL_DESCRIPTION"
    while IFS='' read -r line || [[ -n "$line" ]]; do
        lib="${line%%=*}"
        detail="${line##*=}"

        "$check_cmd" "$lib" && installed="I" || installed="N"
        printf "$DISPLAY_LIBRARY_FORMAT" "$i" "${lib##* }" "$installed" "$detail"
        SHOWED_LIBRARYS+=("$lib")
        i="$((i + 1))"
    done < "$file"
    # "$post_cmd"
}

choose_as_pack() {
    local pack_name="$1" cmd="$2" 
    shift 2
    local else="$@"
    
    choose "'$pack_name' pack" && "$cmd" ${else[@]} # not quote to avoid array merging
}

choose_as_choice() {
    local cmd="$1"
    shift 1
    local arr=($@)

    ask "$CHOOSE_BY_NUMBER"
    index="$ans"
    [ $index -lt 0 ] && return 0
    "$cmd" "${arr[index]}"
}