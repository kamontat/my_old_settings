#!/usr/bin/env bash

# set -x #DEBUG - Display commands and their arguments as they are executed.
# set -v #VERBOSE - Display shell input lines as they are read.
# set -n #EVALUATE - Check syntax of the script but don't execute.

#/ -------------------------------------------------
#/ Description:  Command constants, including app description and version
#/ Create by:    Kamontat Chantrachirathumrong
#/ Since:        12 Mar 2561
#/ -------------------------------------------------
#/ Bug:          no exist
#/ -------------------------------------------------

# -------------------------------------------------
# Constants
# -------------------------------------------------

export MYSN_VERSION="0.1.0-beta.1"
export MYSN_DESCRIPTION="MacOS full settings and customable, made by bash script"
export MYSN_DATE="12 Mar 2561"

export BREW_REQUIRE_USER="To run brew, you must input username (-U <name>)"
export NONE="none"
export NOT_INSTALL_DESCRIPTION="not install any application"
export CHOOSE_BY_NUMBER="Choose by enter? [a    => all]
                 [e    => except installed]
                 [-1|n => not install anything]
                 [0..n => index of application]: "
export CHOOSE_BY_YES_NO="Choose by enter? [Y|n]: "

export LIST_BREW_DEP="List all installed applications..."
export LIST_CASK_BREW_DEP="List all installed cask applications..."

# export SHORT_DISPLAY_LIBRARY_FORMAT="%3d) %-20s (%s) - %s\n"
export DISPLAY_LIBRARY_FORMAT="%3d) %-30s (%s) - %s\n"

export MAS_NOT_EXIST="Mas command not exist, install by brew"
export ASK_EMAIL="Input your email? "
export ASK_USERNAME="Input current username? "
