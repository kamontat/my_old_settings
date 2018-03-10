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


# @explain  - exit non zero code if long opt value is empty
# @require  - throw method in helper_api
# @params  1- error message
#          2- error code
# @return   - message and code handle by $?
throw_if_empty() {
    [ -n "$LONG_OPTVAL" ] && return 0 || throw "$1" $2
}

# @explain  - get key and value automatially
# @require  - use in `getopts` only
set_key_value_long_option() {
    if [[ $OPTARG =~ "=" ]]; then
        LONG_OPTVAL="${OPTARG#*=}"
        LONG_OPTARG="${OPTARG%=$LONG_OPTVAL}"
    else
        LONG_OPTARG="$OPTARG"
        LONG_OPTVAL="$NEXT_PARAMS"
        OPTIND=$((OPTIND + 1))
    fi
}

# @explain  - get key and value automatially
# @require  - use in `getopts` only
require_argument() {
    throw_if_empty "'$LONG_OPTARG' require argument" 9
}

# @explain  - use for no-argument command
# @require  - use in `getopts` only
no_argument() {
    OPTIND=$((OPTIND - 1))
}