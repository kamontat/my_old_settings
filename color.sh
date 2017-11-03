#!/bin/bash

# -------------------------------------------------
# Description:  color api for download script
#               all function on this file called by 1 parameter this the output text
# List Command: get_highlight_color    - gray bg, purple text color (blink, bold, underline)
#               get_header_color       - orange text color (underline)
#               get_name_color         - blue text color
#               get_number_color       - pink text color
#               get_link_color         - green text color (underline)
#               get_load_color         - white text color (bold)
#               get_location_color     - red text color (bold)
#               get_command_color      - white text color (underline)
#               get_option_color       - white, light blue text color
#               get_code_color         - gray bg, white text color
#               get_parameter_color    - yellow, light green text color
# Usage:        run file in `source` command only with 1 parameter [true|false]
# Create by:    Kamontat Chantrachirathumrong
# Since:        09/09/2560
# -------------------------------------------------
# Version:      1.0
# -------------------------------------------------
# Error code:   7                      - color_util.sh not exist
#               8                      - $COLOR_MODE not exist
# -------------------------------------------------
# Bug:
# -------------------------------------------------

# -------------------------------------------------
# Constants
# -------------------------------------------------

COLOR_LOCATION="."

COLOR_VERSION="v4.3.1"

utils_name="color_util.sh"
utils_file="https://github.com/kamontat/bash-color/releases/download/$COLOR_VERSION/$utils_name"

# api function from (utils file)
# @explain    - download file and save in the same name same location
# @params - 1 - url of downloaded file
function load {
    name="$(get_name_from_url $1)"
    curl -o $COLOR_LOCATION/$name -sL -N $1
    chmod 755 $COLOR_LOCATION/$name
}

# @params - 1 - file url
# @return     - name of file in url
function get_name_from_url {
    echo "${1##*/}"
}

# load color for color-util (https://github.com/kamontat/bash-color)
[ -x $1 ] && return 9
[ -f "$COLOR_LOCATION/$utils_name" ] || load $utils_file

if $1; then
    [ -f "$COLOR_LOCATION/$utils_name" ] && source /dev/stdin <<< "$($COLOR_LOCATION/$utils_name load $COLOR_VERSION)" || return 7
else
    [ -f "$COLOR_LOCATION/$utils_name" ] && source /dev/stdin <<< "$($COLOR_LOCATION/$utils_name reset $COLOR_VERSION)" || return 7
    [[ $SILENT -eq 0 ]] && printf "Turn off color mode\n"
fi
[ -n "$C_COMPLETE" ] || C_COMPLETE=0

return 0
