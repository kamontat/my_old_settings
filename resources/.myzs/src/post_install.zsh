clear_env() {
	local env_values
	env_values="$(list_myzs_env)"
	while read -r line; do
		name="${line%%=*}"
		if_debug_print "post install"
		! is_necessary_env "$name" &&
			continue_print "unset $name" &&
			unset "$name" || continue_print "ignore $name"
	done <<<"$env_values"
}

# reset() {
# 	[[ $MYZS_VERBOSE == true ]] && set +x
# }

is_necessary_env() {
	[[ "$1" == "MYZS_ROOT" ]] ||
		[[ "$1" == "MYZS_GLOBAL" ]] ||
		[[ "$1" == "MYZS_DEBUG" ]]
}

clear_env

# reset
