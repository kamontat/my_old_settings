# Main zsh setting file

export MYZS_ROOT="${HOME}/.myzs"
export MYZS_SRC="${HOME}/.myzs/src"
export MYZS_GLOBAL="${MYZS_ROOT}/global"
export MYZS_CUSTOM="${MYZS_ROOT}/custom-libs"

export MYZS_HELPER_CONFIG="${MYZS_SRC}/config.zsh"
export MYZS_HELPER_UTIL="${MYZS_GLOBAL}/utils.func.zsh"

export MYZS_FILE_PLUGIN="${MYZS_SRC}/plugin.zsh"
export MYZS_FILE_THEME="${MYZS_SRC}/theme.zsh"
export MYZS_FILE_SOURCE="${MYZS_SRC}/sourcing.zsh"

export MYZS_FILE_CUSTOM_ENVI="${MYZS_GLOBAL}/settings"
export MYZS_FILE_ENVI="${MYZS_GLOBAL}/environment"
export MYZS_FILE_CUSTOM_ENVI="${MYZS_GLOBAL}/custom_environment"
export MYZS_FILE_CUSTOM_ENVI="${MYZS_GLOBAL}/alias"
export MYZS_FILE_CUSTOM_CLI="${MYZS_GLOBAL}/custom_command_line_interface"

export MYZS_POST_INSTALL="${MYZS_SRC}/post_install.zsh"

export MYZS_FILE_CORRECT="${MYZS_CUSTOM}/correction.zsh"
export MYZS_FILE_CORRECT="${MYZS_CUSTOM}/history.zsh"

export MYZS_TEMP_FOLDER="/tmp/myzs"
mkdir $MYZS_TEMP_FOLDER &>/dev/null
export MYZS_TEMP_FILE="$MYZS_TEMP_FOLDER/temp"
export MYZS_LOG_FILE="$MYZS_TEMP_FOLDER/myzs.log"
export MYZS_ERROR_FILE="$MYZS_TEMP_FOLDER/myzs.error"

# 1 - title
# 2 - message
if_debug_print() {
	[[ $MYZS_DEBUG == false ]] && return 0
	local date_char=15 head_char=25 nl="\n"
	local t="$1"
	shift
	local m="$*"
	test -z "$m" && nl=""
	printf "%-${date_char}s %${head_char}s - %s$nl" "$(date)" "$t" "$m"
}

if_debug_print_error() {
	if_debug_print $@ >&2
}

continue_print() {
	[[ $MYZS_DEBUG == false ]] && return 0
	printf "%s\n" "$*"
}

loading_files() {
	while read -r file; do
		value="${file##*=}"
		if [ -f "$value" ]; then
			source "$value" 2>${MYZS_ERROR_FILE} &&
				if_debug_print "load status" "${value##*/} exist!" "'Loaded'" ||
				if_debug_print_error "load status" "${value##*/} exist!" "'ERROR'"
		else
			if_debug_print_error "load status" "${value##*/} NOT exist!"
		fi
	done <<<"$1"
}

list_myzs_env() {
	echo "$(env | grep "MYZS_")"
}

list_myzs_file_env() {
	echo "$(env | grep "MYZS_FILE")"
}

list_myzs_helper_env() {
	echo "$(env | grep "MYZS_HELPER")"
}

list_myzs_post_env() {
	echo "$(env | grep "MYZS_POST")"
}

print_myzs_env() {
	! $MYZS_DEBUG && return 0
	local env_values name value
	env_values="$(list_myzs_env)"
	while read -r line; do
		name="${line%%=*}"
		value="${line##*=}"
		if_debug_print "$name" "$value"
	done <<<"$env_values"
}

# pre install
loading_files "$(list_myzs_helper_env)"
# print environment
print_myzs_env
# install
loading_files "$(list_myzs_file_env)"
# post install
loading_files "$(list_myzs_post_env)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
