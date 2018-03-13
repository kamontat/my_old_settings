#!/usr/bin/env bash

# set -x #DEBUG - Display commands and their arguments as they are executed.
# set -v #VERBOSE - Display shell input lines as they are read.
# set -n #EVALUATE - Check syntax of the script but don't execute.

#/ -------------------------------------------------
#/ Title:        Application script
#/ -------------------------------------------------
#/ Description:  This script will setting both applications and application
#/               You can found list of applications on 'resource' folders
#/ Create by:    Kamontat Chantrachirathumrong
#/ Since:        10 Mar 2561
#/ -------------------------------------------------
#/ Version:      2.1.1  -- remove pack application
#/ -------------------------------------------------
#/ Bug:          no exist
#/ -------------------------------------------------

only_applications() {
	_only_choose_applications
	# _only_pack_applications
}

specify_applications() {
	local name="$1"
	ask_to_choose "${RESOURCES_APPL}/${name}.txt" "$name"
}

# -------------------------------------------------
# Functions
# -------------------------------------------------

_only_choose_applications() {
	loop_each_files "${RESOURCES_APPL}/$choose_files" ask_to_choose
}

# _only_pack_applications() {
# 	loop_each_files "${RESOURCES_APPL}/$pack_files" ask_to_pack
# }
