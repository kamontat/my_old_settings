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
# throw() {
# 	printf "%s\n" "$1" >&2 && exit $2
# }

# @explain  - check is input is integer?
# @params  1- variable to check
# @return   - 0 if is a boolean; otherwise, return 1
is_integer() {
	[[ $1 =~ ^[0-9]+$ ]] 2>/dev/null && return 0 || return 1
}

# @explain  - exit non zero code with message
# @params  1- error message
#          2- error code (optional) -- if don't have error log only not exit
throw() {
	printf '%s\n' "$1" >&2 && is_integer "$2" && exit "$2"
	return 0
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
	[ "$3" == "false" ] && cmd=("cp") || cmd=("sudo" "cp")
	${cmd[@]} -rf "$1" "$2"
}

# @explain  - move file to other location
# @params  1- file or folder
#          2- output location
#          3- false, for non-root command
move() {
	[ "$3" == "false" ] && cmd=("mv") || cmd=("sudo" "mv")
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
	askone "Do you want $1? [Y|n]: "
	# res="$(askone "Do you want $1? [Y|n]: ")"
	echo && [ "$ans" != "n" ]
}

askone() {
	[[ $ALWAYS_YES == true ]] && ans="Y" && return 0

	unset ans
	printf "%s" "$1" &&
		read -rn 1 ans
	export ans

}

ask() {
	[[ $ALWAYS_YES == true ]] && ans="e" && return 0

	unset ans
	printf "%s" "$1" &&
		read -r ans
	export ans
}

tell() {
	echo "$@"
}

is_command_exist() {
	command -v "$1" >/dev/null
}

# 1 - filename
# 2 - link
# 3 - is_silent
download_file() {
	local f="${TEMP}/$1" opt="-sLo"
	! $3 && opt="-Lo"
	$cache && [ -f "$f" ] || [ -d "$f" ] && echo "${f}" && return 0 # cache file
	curl "$opt" "${f}" "$2" &&
		echo "${f}"
}

download_file_same_name() {
	local location="$PWD"
	cd ${TEMP} && curl -LOJ -C - "$1" -w "${TEMP}/%{filename_effective}"
	cd "$location"
}

unzip_file() {
	local f="${TEMP}/$1" o="${TEMP}"
	unzip "$f" -d "$o" >/dev/null
}

get_harddrive_name() {
	find /Volumes -type l -depth 1 -maxdepth 1 -mindepth 1
}

random() {
	od -An -N8 -H </dev/random | tr -d " " | tr -d "\n"
}

create_temp_file() {
	file="${TEMP}/mysn.$(random)$1"
	touch $file
	echo "$file"
}

create_temp_folder() {
	folder="${TEMP}/mysn.$(random)$1"
	mkdir $folder
	echo "$folder"
}

if_extension_of() {
	local location="$1" extension="$2"
	echo "${location##*.}" | grep -qi "^${extension}$"
}
