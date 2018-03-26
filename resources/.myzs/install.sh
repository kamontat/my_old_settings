#!/usr/bin/env bash

# set -x #DEBUG - Display commands and their arguments as they are executed.
# set -v #VERBOSE - Display shell input lines as they are read.
# set -n #EVALUATE - Check syntax of the script but don't execute.

#/ -------------------------------------------------
#/ Description:  Install script
#/               To install script,
#/                 1. This will verify by validate checksum
#/                 2. This will copy this project to
#/                    $HOME/.myzs/ folder, this will fail if directory is exist
#/                 3. create symlink between '$HOME/.myzs/.zshrc' and '$HOME/.zshrc'
#/                    this will fail if file exist
#/ Create by:    Kamontat Chantrachirathumrong
#/ Since:        27/03/2018
#/ -------------------------------------------------
#/ Version:      0.0.1  -- add help command
#/               1.0.0  -- production
#/ -------------------------------------------------
#/ Error code    1      -- common error
#/ -------------------------------------------------
#/ Known bug:    not exist
#/ -------------------------------------------------

help() {
	local t="$PWD"
	cd "$(dirname "$0")"
	cat "install.sh" | grep "^#/" | tr -d "#/"
	cd "$t"
}

validate() {
	local t="$PWD" exit_code=0
	cd "$(dirname "$0")"
	$PWD/validate.sh >/tmp/myzs/install.log || exit_code=$?
	cd "$t"
	return $exit_code
}

create_link() {
	local t="$PWD" exit_code=0
	cd "$(dirname "$0")"
	ln -s $PWD/.zshrc $HOME/.zshrc || exit_code=$?
	cd "$t"
	return $exit_code
}

# -------------------------------------------------
# Constants
# -------------------------------------------------

if [ "$1" == "help" ] ||
	[ "$1" == "--help" ] ||
	[ "$1" == "h" ] ||
	[ "$1" == "-h" ] ||
	[ "$1" == "?" ] ||
	[ "$1" == "-?" ]; then
	help "$0" && exit
fi

printf "validating.. (BY CHECKSUM)"
validate && echo " -> complete" || echo " -> exit by $?"

printf "cloning.."
! test -d "$HOME/.myzs" &&
	mkdir "$HOME/.myzs" &&
	cp -r . "$HOME/.myzs" &&
	echo " -> complete" ||
	echo " -> exit by $?"

printf "creating link.. (REMOVE .ZSHRC FIRST)"
! test -f "$HOME/.zshrc" && ! test -L "$HOME/.zshrc" &&
	create_link &&
	echo " -> complete" ||
	echo " -> exit by $?"
