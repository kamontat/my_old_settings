# $1 => file to output
# $2 => line number (optional)
#       can be single number like 40
#              length        like 14-55
#              multiple      like 12,44,55
cat-syntax() {
	! if_command_exist "pygmentize" && echo "require pygmentize to run" && return 1

	if [ -f "$1" ]; then
		local t
		local T
		# highlight syntax
		t=$(pygmentize "$1" 2>/dev/null || pygmentize -l text "$1")
		# add line number
		# shellcheck disable=SC1001
		T=$(echo "$t" | \cat -n)
		# if have $2
		if [ -n "$2" ]; then
			T=$(echo "$T" | grep "$2")
		fi
		echo "$T"
	else
		echo "require 1 file as parameter."
		return 1
	fi
}

# countdown
countdown() {
	! if_command_exist "termdown" && echo "termdown not exist" && return 1
	local time="$1"
	shift
	termdown "$time" -v "Veena" "$@"
}

timer() {
	! if_command_exist "termdown" && echo "termdown not exist" && return 1
	termdown
}

if_file_exist() {
	[ -f "$1" ]
}

if_folder_exist() {
	[ -d "$1" ]
}

if_command_exist() {
	command -v "$1" &>/dev/null
}

load() {
	local f="$1" t
	t="$(source "$f")"
	if_debug_print "status" "${f##*/} exist!" "'Loaded'"
	test -n "$t" && echo "$t"
}
