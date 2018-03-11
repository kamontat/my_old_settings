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
#/ Version:      1.1.0  -- improve method of brew command
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
    echo "$LIST_CASK_BREW_DEP"
    list_cask_brew
}

# -------------------------------------------------
# Functions
# -------------------------------------------------

_install_multiple_brew_application() {
    loop_on_files "${RESOURCES_BREW}/applications/choose-*.txt" "_choose_to_install_brew_application"

    loop_on_files "${RESOURCES_BREW}/applications/pack-*.txt" "_install_brew_application_pack"
}

_choose_to_install_brew_application() {
    loop_show_library "$1" "brew_save_list" "is_cask_installed" true
    choose_as_choice brew_cask_install ${SHOWED_LIBRARYS[@]}
}

_install_brew_application_pack() {
    loop_show_library "$1" "brew_save_list" "is_cask_installed"
    choose_as_pack "${2##*-}" brew_cask_install "${SHOWED_LIBRARYS[@]}"
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