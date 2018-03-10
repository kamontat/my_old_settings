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
# Constants
# -------------------------------------------------


# -------------------------------------------------
# Functions
# -------------------------------------------------

only_application() {
    _only_dmg_application
}

_only_dmg_application() {
    echo "Install .dmg application.."
    
    choose "firefox" && 
        _download_and_install_dmg "https://download.mozilla.org/?product=firefox-latest-ssl&os=osx&lang=th" "ff"
    choose "google file system" && 
        _download_and_install_dmg "https://dl.google.com/drive-file-stream/googledrivefilestream.dmg" "gdfs"
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