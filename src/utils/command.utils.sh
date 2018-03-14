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
# BREW Functions
# -------------------------------------------------

run_brew() {
	[ "$user" == "root" ] || [ "$user" == "" ] &&
		throw "$BREW_REQUIRE_USER" &&
		ask "$ASK_USERNAME" &&
		export user="$ans"

	sudo -u "$user" brew "$@"
}

run_brew_cask() {
	run_brew cask "$@"
}

brew_install() {
	run_brew install "$@"
}

brew_cask_install() {
	run_brew_cask install "$@"
}

# install only 1 app at a time
# 1 - appID
mas_install() {
	is_command_exist "mas" || throw "$MAS_NOT_EXIST" 5
	mas install "$1"
}

# install finded 1 app at a time
# 1 - app name
mas_install_by_name() {
	is_command_exist "mas" || throw "$MAS_NOT_EXIST" 5
	mas lucky "$1"
}

mas_list() {
	is_command_exist "mas" || throw "$MAS_NOT_EXIST" 5
	mas list
}

validate_brew() {
	run_brew doctor
	run_brew_cask doctor
}

list_all_brew() {
	list_brew
	list_cask_brew
}

list_brew() {
	run_brew list
}

list_cask_brew() {
	run_brew_cask list
}

brew_installation() {
	for lib in "$@"; do
		check_txt_is_cask "${lib##* }" && brew_cask_install "${lib##* }" && break
		brew_install "${lib##* }"
	done
}

# -------------------------------------------------
# <> Functions
# -------------------------------------------------

is_installed() {
	check_txt_is_cask "$1" &&
		is_cask_installed "$RAW_LIBRARY_NAME" ||
		is_brew_installed "$RAW_LIBRARY_NAME"
}

is_brew_installed() {
	[ -z "$BREW_LIST" ] && export BREW_LIST="$(list_brew)"
	echo "$BREW_LIST" | grep -q "^$1$"
}

is_cask_installed() {
	[ -z "$BREW_CASK_LIST" ] && export BREW_CASK_LIST="$(list_cask_brew)"
	echo "$BREW_CASK_LIST" | grep -q "^$1$"
}

is_app_installed() {
	ls /Applications/* | grep -qi "$1"
}

is_command_installed() {
	is_command_exist "$1"
}

is_dict_installed() {
	ls /Library/Dictionaries | grep -qi "$1"
}

is_directory_installed() {
	ls ~/$1 &>/dev/null
}

is_mas_installed() {
	mas_list | grep -qi "$1"
}
