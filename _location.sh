#!/usr/bin/env bash

# set -x #DEBUG - Display commands and their arguments as they are executed.
# set -v #VERBOSE - Display shell input lines as they are read.
# set -n #EVALUATE - Check syntax of the script but don't execute.


#/ -------------------------------------------------
#/ Description:  location of the project (source this file every first file)
#/ Create by:    Kamontat Chantrachirathumrong
#/ Since:        10 Mar 2561
#/ -------------------------------------------------
#/ Version:      0.0.1  -- export sevenal variable
#/ -------------------------------------------------

cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

# -------------------------------------------------
# Constants
# -------------------------------------------------

export ROOT="$PWD"
export SRC="${PWD}/src"

export UTILS="${SRC}/utils"
export SCRIPTS="${SRC}/scripts"
export CONSTANTS="${SRC}/constants"

export RESOURCES="${ROOT}/resources"
export RESOURCES_DMG="${RESOURCES}/dmg_files"
export RESOURCES_DOT="${RESOURCES}/dot_files"
export RESOURCES_OTH="${RESOURCES}/others"

export TEMP="/tmp"