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