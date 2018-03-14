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

check_volume() {
	ls /Volumes
}

reset() {
	unset MOUNT_VOLUME
}

mount_dmg() {
	local o
	o="$(create_temp_folder)"
	hdiutil attach -mountpoint "$o" "$1" >/dev/null
	export MOUNT_VOLUME="$o"
}

unmount_dmg() {
	[ -z "$MOUNT_VOLUME" ] && export MOUNT_VOLUME="$1"
	hdiutil detach "$MOUNT_VOLUME" >/dev/null
}

install() {
	local app pkg installer_type
	[ -z "$MOUNT_VOLUME" ] && export MOUNT_VOLUME="$1"
	[ -n "$2" ] && installer_type="$2"
	[ "$installer_type" == "app" ] && app="$3"
	[ "$installer_type" == "pkg" ] && pkg="$3"

	[ -z "$app" ] && app="$(ls -1 "$MOUNT_VOLUME" | grep ".app$")"
	[ -z "$pkg" ] && pkg="$(ls -1 "$MOUNT_VOLUME" | grep ".pkg$")"

	# echo "app call -> $app"
	# echo "pkg call -> $pkg"

	if [[ "$app" != "" ]]; then
		_copy_if_app "${MOUNT_VOLUME}/${app}"
	elif [[ "$pkg" != "" ]]; then
		_copy_if_pkg "${MOUNT_VOLUME}/${pkg}"
	else
		throw "unknown application format @$MOUNT_VOLUME"
	fi
}

# 1 - link
# 2 - unique key of each installer
download_and_install_dmg() {
	local link="$1" name="installer.${2}.dmg" location

	location=$(download_file "$name" "$link" false)

	reset
	mount_dmg "$location"
	install
	unmount_dmg
}

download_and_install_pkg() {
	local link="$1" name="installer.${2}.pkg" location

	location=$(download_file "$name" "$link" false)

	install "$location" ""
}

install_link() {
	local link="$1"
	location=$(download_file_same_name "$link" false)

	if_extension_of "$location" "sh" && bash "$location"
}

install_dict() {
	install "${RESOURCES_PKGA}" "pkg" "$1"
}

install_mas() {
	mas_install "$1"
}

_copy_if_app() {
	local app="$1"
	sudo cp -R "$app" "/Applications" || throw "cannot install app {$app}"
}

_copy_if_pkg() {
	local pkg="$1"
	sudo installer -pkg "$pkg" -target "$(get_harddrive_name)"
}

loop_each_files() {
	local files="$1" command="$2" name file
	for file in $(ls $files); do
		name="${file##*/}"
		name="${name%%.*}"
		"$command" "$file" "$name"
	done
}

# @return  - array of triple key
# 			 1 - library install type
# 			 2 - library name
# 			 3 - library extension
loop_each_libraries() {
	local file="$1" include_minus="$2"
	local lib    # library name
	local detail # description of library
	local ext    # extension of library, like 'link'
	local line i installed

	export SHOWED_LIBRARYS=()

	[[ $include_minus == true ]] &&
		printf "$DISPLAY_LIBRARY_FORMAT" -1 "$NONE" " " "$NOT_INSTALL_DESCRIPTION"
	while IFS='' read -r line || [[ -n "$line" ]]; do
		lib="${line%%=*}"
		detail="${line##*=}"
		ext="$(echo "$detail" | grep -o {.*})"
		detail="${detail//$ext/ }"
		ext="$(echo "$ext" | tr -d "{" | tr -d "}")" # remove "{", "}"

		check_is_installed "$lib" && installed="I" || installed="N"

		# printf "ext: %s\n" "$ext"
		printf "$DISPLAY_LIBRARY_FORMAT" "$i" "${lib##* }" "$installed" "$detail"
		[ -z "$ext" ] && SHOWED_LIBRARYS+=("$lib") || SHOWED_LIBRARYS+=("$lib $ext")
		i="$((i + 1))"
	done <"$file"
}

# @deprecated
# ask_to_pack() {
# 	local filename="$1"
# 	local packname="$2"

# 	loop_each_libraries "$filename"

# 	choose "'$packname' pack" || return 0 # not choose this pack

# 	local lib
# 	for lib in "${SHOWED_LIBRARYS[@]}"; do
# 		before_check_txt "$lib"
# 		install_applications
# 	done

# 	# choose "'$pack_name' pack" && "$install_cmd" ${else[@]} # not quote to avoid array merging
# }

ask_to_choose() {
	local list filename="$1"
	local packname="$2"

	loop_each_libraries "$1" true

	ask "$CHOOSE_BY_NUMBER"
	list=($ans)
	[ -z "$list" ] && return 0                                              # list not exist
	[ "${#list[@]}" -lt 1 ] && return 0                                     # zero list
	[[ "${list[*]}" =~ "^[^0-9 ]+$" ]] && return 0                          # non number
	[[ "${list[*]}" =~ "n" ]] && return 0                                   # not install
	[[ "${list[*]}" =~ "a" ]] && install_all_applications false && return 0 # install every application
	[[ "${list[*]}" =~ "e" ]] && install_all_applications true && return 0  # install not installed application

	for index in "${list[@]}"; do
		[ "$index" -lt 0 ] && return 0                        # minus input
		[ "$index" -ge "${#SHOWED_LIBRARYS[@]}" ] && return 0 # exceed array
		before_check_txt "${SHOWED_LIBRARYS[index]}"
		install_applications
	done
}

# use after method 'before_check_txt'
# 1 = library type, 2 = library name, 3 = library extra information
install_applications() {
	[[ "$1" == true ]] && check_is_installed "$RAW_LIBRARY_NAME" && return 0
	check_txt_is "cask" && brew_cask_install "$RAW_LIBRARY_NAME" && return 0
	check_txt_is "brew" && brew_install "$RAW_LIBRARY_NAME" && return 0
	check_txt_is "link" && install_link "$RAW_LIBRARY_EXTR" && return 0
	check_txt_is "dict" && install_dict "$RAW_LIBRARY_EXTR" && return 0
	check_txt_is "mas" && install_mas "$RAW_LIBRARY_EXTR" && return 0

	# echo "Installation not exist!" >&2
}

install_all_applications() {
	local lib
	for lib in "${SHOWED_LIBRARYS[@]}"; do
		before_check_txt "$lib"
		install_applications "$1"
	done

	return 0
}
