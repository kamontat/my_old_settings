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

export date="$(date +%d%m%y%H)"
export cache_postfix=".${date}.my_setting_cache"

# -------------------------------------------------
# Functions
# -------------------------------------------------

# @explain  - exit non zero code with message
# @params  1- error message
#          2- error code
throw() {
    printf "%s\n" "$1" && exit $2
}

# @explain  - the help utils to generate help command of the script
# @params  1- file for run help command
help() {
  cat "$1" | grep "^#/" | tr -d "#/"
}

# @explain  - copy file to other location
# @params  1- file or folder
#          2- output location
#          3- false, for non-root command
copy() {
    [ "$3" == "false" ] && cmd=("cp") ||  cmd=("sudo" "cp")
    ${cmd[@]} -rf "$1" "$2"
}

# @explain  - move file to other location
# @params  1- file or folder
#          2- output location
#          3- false, for non-root command
move() {
    [ "$3" == "false" ] && cmd=("mv") ||  cmd=("sudo" "mv")
    ${cmd[@]} -rf "$1" "$2"
}

# @explain  - save cache (as DayMonthYearHour)
# @params  1- file or folder
cache() {
    move "$1" "$1$cache_postfix"
}

# @explain  - copy file to other location, if exist cache it first
# @params  1- file or folder
#          2- output location
#          3- false, for non-root command
save_copy() {
    in="$1"
    out="$2"
    [ -f "$out" ] && cache "$2"
    copy "$1" "$2" "$3"
}

who() {
    whoami
}

list_shell() {
    grep -v "#" </etc/shells
}

choose() {
    printf "Do you want %s? [Y|n]: " "$1"
    read -rn 1 ans && 
        echo && 
        [ $ans != "n" ]
}

is_command_exist() {
    command -v "$1" >/dev/null
}