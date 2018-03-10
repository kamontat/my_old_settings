#!/usr/bin/env bash

# set -x #DEBUG - Display commands and their arguments as they are executed.
# set -v #VERBOSE - Display shell input lines as they are read.
# set -n #EVALUATE - Check syntax of the script but don't execute.


#/ -------------------------------------------------
#/ Description:  Application install with dmg files, brew cask and more...
#/               You can found list of every application on 'resource' folders
#/               This script have 2 type of question
#/                 1. 'choose' question => you can only choose '1' of them
#/                 2. 'pack' question   => you have to install 
#/                                         every application in pack, 
#/                                         if you said 'yes'. but you can uninstall later
#/ Create by:    Kamontat Chantrachirathumrong
#/ Since:        11 Mar 2561
#/ -------------------------------------------------
#/ Version:      1.0.0  -- finish first version
#/ -------------------------------------------------
#/ Bug:          no exist
#/ -------------------------------------------------

only_application() {
    # only_dmg_application
    only_brew_application
}

only_dmg_application() {
    echo "Install .dmg application.."
    
    # choose "firefox" && 
    #     _download_and_install_dmg "https://download.mozilla.org/?product=firefox-latest-ssl&os=osx&lang=th" "ff"
    # choose "google file system" && 
    #     _download_and_install_dmg "https://dl.google.com/drive-file-stream/googledrivefilestream.dmg" "gdfs"
}

only_brew_application() {
    check_brew

    _install_multiple_brew_application

    validate_brew
    echo "List all installed cask dependencies..."
    list_cask_brew
}

# -------------------------------------------------
# Functions
# -------------------------------------------------

_install_multiple_brew_application() {
    local name 
    for file in $(ls ${RESOURCES_BREW}/applications/choose-*.txt); do
        name="${file##*/}"
        name="${name%%.*}"
        _choose_to_install_brew_application "$file" "$name"
    done

    for file in $(ls ${RESOURCES_BREW}/applications/pack-*.txt); do
        name="${file##*/}"
        name="${name%%.*}"
        _install_brew_application_pack "$file" "$name"
    done
}

_choose_to_install_brew_application() {
    local line file="$1" arr=() 
    local lib detail i=0 index

    printf "%3d) %-25s - %s\n" -1 "none" "not install any application"
    while IFS='' read -r line || [[ -n "$line" ]]; do
        lib="${line%%=*}"
        detail="${line##*=}"
        printf "%3d) %-25s - %s\n" "$i" "${lib##* }" "$detail"
        arr+=("$lib")
        i="$((i + 1))"
    done < "$file"

    ask "Choose install by enter number [-1|0|1|..]? "
    index="$ans"
    [ $index -lt 0 ] && return 0
    brew_cask_install "${arr[index]}"
}

_install_brew_application_pack() {
    local line file="$1" arr=()
    local lib detail i=0

    while IFS='' read -r line || [[ -n "$line" ]]; do
        i="$((i + 1))"
        lib="${line%%=*}"
        detail="${line##*=}"
        printf "%3d) %-20s - %s\n" "$i" "${lib##* }" "$detail"
        arr+=("$lib")
    done < "$file"

    choose "'${2##*-}' pack" && brew_cask_install "${arr[@]}"
}

# 1 - link
# 2 - unique key of each installer
_download_and_install_dmg() {
    local link="$1" name="installer.${2}.dmg" location

    location=$(download_file "$name" "$link" false)
    
    reset
    mount_dmg "$location"
    install_dmg
    unmount_dmg
}