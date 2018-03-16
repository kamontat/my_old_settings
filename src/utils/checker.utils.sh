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
# Functions
# -------------------------------------------------

# 0 - macOS
# 1 - Linux
# 2 - else
check_os() {
	os="$(uname)"
	[[ "$os" == "Darwin" ]] && echo 0 && return 0
	[[ "$os" == "Linux" ]] && echo 1 && return 0
	echo 2 && return 1
}

check_brew() {
	is_command_exist "brew" && echo "brew is installed" && return 0
	[ $(check_os) != 0 ] && return 1
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	run_brew tap caskroom/versions
	run_brew tap caskroom/fonts
}

check_user() {
	local user="$(who)"
	# ref: https://askubuntu.com/a/30157/8698
	# if [ "$(id -u)" -ne 0 ]; then
	if [ $user != "root" ]; then
		echo "run as $user! ->
    I suggest you to run as root by add 'sudo' to the front of index"
		printf "Do you sure? [Y|n] "
		read -rn 1 ans
		[[ $ans == "n" ]] && echo && exit 1 || echo
	else
		echo "Run as Administrator!"
		# echo "Shouldn't run as 'root' at default"
		# exit 1
	fi
}

before_check_txt() {
	local a="$1"
	local arr=($a)
	export RAW_HEADER_NAME="${arr[0]}"  # cask or link
	export RAW_LIBRARY_NAME="${arr[1]}" # name
	export RAW_LIBRARY_EXTR="${arr[2]}" # extra information
}

check_txt_is() {
	[ "$RAW_HEADER_NAME" == "$1" ]
}

check_is_installed() {
	[ -n "$1" ] && before_check_txt "$1"
	check_txt_is "cask" && is_cask_installed "$RAW_LIBRARY_NAME" && return 0
	check_txt_is "brew" && is_brew_installed "$RAW_LIBRARY_NAME" && return 0
	check_txt_is "dmg" ||
		check_txt_is "link" && is_app_installed "$RAW_LIBRARY_NAME" && return 0
	check_txt_is "dmg" ||
		check_txt_is "link" && is_command_installed "$RAW_LIBRARY_NAME" && return 0
	check_txt_is "link" && is_directory_installed "$RAW_LIBRARY_NAME" && return 0
	check_txt_is "dict" && is_dict_installed "$RAW_LIBRARY_NAME" && return 0
	check_txt_is "mas" && is_mas_installed "$RAW_LIBRARY_NAME" && return 0

	return 1
}
