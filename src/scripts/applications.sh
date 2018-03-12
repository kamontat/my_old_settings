#!/usr/bin/env bash

# set -x #DEBUG - Display commands and their arguments as they are executed.
# set -v #VERBOSE - Display shell input lines as they are read.
# set -n #EVALUATE - Check syntax of the script but don't execute.

#/ -------------------------------------------------
#/ Title:        application script
#/ -------------------------------------------------
#/ Description:  This script will setting both applications and application
#/               You can found list of applications on 'resource' folders
#/ Create by:    Kamontat Chantrachirathumrong
#/ Since:        10 Mar 2561
#/ -------------------------------------------------
#/ Version:      2.0.1  -- clean code
#/ -------------------------------------------------
#/ Bug:          no exist
#/ -------------------------------------------------

only_applications() {
	_only_choose_applications
	_only_pack_applications
}

# -------------------------------------------------
# Functions
# -------------------------------------------------

_only_choose_applications() {
	loop_each_files "${RESOURCES_APPL}/$choose_files" ask_to_choose
}

_only_pack_applications() {
	loop_each_files "${RESOURCES_APPL}/$pack_files" ask_to_pack
}

# _only_brew_application() {
# 	check_brew

# 	_load_multiple_applications

# 	echo "$LIST_BREW_DEP"
# 	list_all_brew
# }

# _only_link_application() {
# 	loop_each_files "${RESOURCES_EXTD}/pack-*.txt" _load_applications
# 	loop_each_files "${RESOURCES_EXTD}/choose-*.txt" _choose_applications
# }

# _load_multiple_applications() {
# 	loop_each_files "${RESOURCES_APPL}/pack-*.txt" _load_brew_applications
# 	loop_each_files "${RESOURCES_APPL}/choose-*.txt" _choose_install_brew_applications
# }

# _load_brew_applications() {
# 	loop_each_libraries "$1" "brew_save_list" is_installed
# 	choose_as_pack "$2" brew_installation "${SHOWED_LIBRARYS[@]}"
# }

# _choose_install_brew_applications() {
# 	loop_each_libraries "$1" "brew_save_list" is_installed true
# 	choose_as_choice brew_installation ${SHOWED_LIBRARYS[@]}
# }
