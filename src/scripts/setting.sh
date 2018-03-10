#!/usr/bin/env bash

# set -x #DEBUG - Display commands and their arguments as they are executed.
# set -v #VERBOSE - Display shell input lines as they are read.
# set -n #EVALUATE - Check syntax of the script but don't execute.

#/ -------------------------------------------------
#/ Title:        Setting script
#/ -------------------------------------------------
#/ Description:  This contains computer settings for mac user
#/               - Key Mouse and Trackpad speed
#/               - Dock size and other utilities
#/               - Power setting (including both battery and AC power)
#/               - Screen saver
#/ Warning:      must run with 'index.sh' only
#/ -------------------------------------------------
#/ Create by:    Kamontat Chantrachirathumrong
#/ Since:        11 Mar 2561
#/ -------------------------------------------------
#/ Version:      1.0.0  -- finish 1 version
#/ -------------------------------------------------
#/ Bug:          no exist
#/ -------------------------------------------------

only_mac_setting() {
    [ "$(check_os)" != "0" ] && throw "must run on macOS" 3

    echo "Speed setting.."
    _choose_default_setting "key repeat rate"           "-g" "KeyRepeat" "int" 2
    _choose_default_setting "delay before key repeat"   "-g" "DelayUntilRepeat" "int" 3
    _choose_default_setting "mouse speed"               "-g" "com.apple.mouse.scaling" "int" "2"
    _choose_default_setting "trackpad speed"            "-g" "com.apple.trackpad.scaling" "int" "2"
    echo "Dock settings.."
    _choose_default_setting "dock size"                 "" "com.apple.dock tilesize" "int" 70
    _choose_default_setting "scroll mouse to open app"  "" "com.apple.dock scroll-to-open" "bool" "TRUE"
    # not available in HighSierra MacOS
    # _choose_default_setting "run dark mode theme" "-g" "AppleInterfaceTheme" "string" "Dark" 
    killall Dock
    echo "Power setting.."
    _choose_power_management_setting "On ac power" "c" 0 15 0
    _choose_power_management_setting "On battary" "b" 20 20 20
    
    choose "watch screen saver" && _download_screen_saver

    ext_help
}

ext_help() {
    echo "
To setup mouse..
    >> System Preferences -> Mouse
To setup trackpad..
    >> System Preferences -> Trackpad
To setup keyboard shortcut..
    >> System Preferences -> Keyboard -> shortcuts -> Spotlight -> 'option+space'
To setup dark mode
    >> System Preferences -> General -> 'Use dark menu bar and Dock'
    "
}

# -------------------------------------------------
# Functions
# -------------------------------------------------

_download_screen_saver() {
    local fullname name
    local link="http://www.rasmusnielsen.dk/download.php?type=applewatch-screensaver"
    name="WatchOSX"
    fullname="$(download_file "$name" "$link")"
    [ -f "$fullname" ] && unzip_file "$name" 

    # -W => Causes open to wait until the applications it opens (or that were already open) have exited.
    # -n => Open a new instance of the application(s) even if one is already running.
    open -Wn "${TEMP}/WatchOSX.saver/" 
}

_choose_default_setting() {
    _raw_choose_default_setting "Setting '$1' [default=$5]? " "$3" "$5" "$2" "-$4"
}

_raw_choose_default_setting() {
    local desc="$1" name="$2" def="$3" g="$4" type="$5"

    ask "$desc"
    [ -n "$ans" ] && def="$ans"

    defaults write "$g" "$name" "$type" "$def"
}

_choose_power_management_setting() {
    local desc="$1" type="$2" syst="$3" disk="$4" disp="$5"
    echo "$1"
    ask "  system-sleep [default=$syst]? "
    [ -n "$ans" ] && syst="$ans"
    ask "  disk-sleep [default=$disk]? "
    [ -n "$ans" ] && disk="$ans"
    ask "  display-sleep [default=$disp]? "
    [ -n "$ans" ] && disp="$ans"

    sudo pmset -"$type" \
	    sleep "$syst" \
	    disksleep "$disk" \
	    displaysleep "$disp"
}

# -------------------------------------------------
# App logic
# -------------------------------------------------

