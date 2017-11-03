#!/bin/bash
# set -x # debug
set -e # force exit if nonzero code

cd "$(dirname "$0")"

cache_postfix="cache"

validate_version() {
    local t
    t=$(echo "$1" | grep -o -E "v([^.a-zA-Z ]+)")
    [[ $1 != "$t" ]] && echo "$1 is not valid version" && exit 1
    return 0
}

# must be v1 v2 v3 ...
# without any dot prefix or more
t="$(git tag)"
old_version="${t##*$'\n'}"
validate_version "$old_version"

version="v$((${old_version##v} + 1))"
validate_version "$version"

# echo "$old_version"
# echo "$version"

# -------------------------------------------------
# Prompt
# -------------------------------------------------

# ref: https://askubuntu.com/a/30157/8698
# if [ "$(id -u)" -ne 0 ]; then
#     echo "run as $user! ->
#     I suggest you to run as root by add 'sudo ./install.sh'"
#     printf "Do you sure? [y|n] "
#     read -rn 1 ans
#     [[ $ans == "n" ]] && exit 1
# else
#     echo "run as Administrator!"
# fi

# -------------------------------------------------
# Functions
# -------------------------------------------------

# @explain    - exit non zero code with message
# @params - 1 - error message
#           2 - error code
throw() {
    printf "%s\n" "$1" && exit $2
}

# @explain    - exit non zero code if long opt value is empty
# @require    - throw method in helper_api
# @params - 1 - error message
#           2 - error code
# @return     - message and code handle by $?
throw_if_empty() {
    [ -n "$LONG_OPTVAL" ] && return 0 || throw "$1" $2
}

# @explain    - get key and value automatially
# @require    - use in `getopts` only
set_key_value_long_option() {
    if [[ $OPTARG =~ "=" ]]; then
        LONG_OPTVAL="${OPTARG#*=}"
        LONG_OPTARG="${OPTARG%=$LONG_OPTVAL}"
    else
        LONG_OPTARG="$OPTARG"
        LONG_OPTVAL="$NEXT_PARAMS"
        OPTIND=$((OPTIND + 1))
    fi
}

# @explain    - get key and value automatially
# @require    - use in `getopts` only
require_argument() {
    throw_if_empty "'$LONG_OPTARG' require argument" 9
}

no_argument() {
    OPTIND=$((OPTIND - 1))
}

# @explain    - copy file to other location
# @params - 1 - file or folder
#           2 - output location
copy() {
    cp -rf "$1" "$2"
}

# @explain    - save cache (as DayMonthYearHour)
# @params - 1 - file or folder
cache() {
    copy "$1" "$1.$(date +%d%m%y%H).$cache_postfix"
}

# @explain    - try to move setting file to location
# @params - 1 - setting file / folder
#           2 - result location
move_setting() {
    file="$1"
    result="$2"
    [ -d "$result" ] && result="$result/${file##*/}"

    # copy
    if [ ! -f "$result" ]; then
        copy "$file" "$result" && echo "${C_FG_1}copy${C_RE_AL} $file -> $result" || return $?
        return 0
    fi
    # replace
    cache "$result" &&
        copy "$file" "$result" &&
        echo "${C_FG_1}replaced${C_RE_AL} ($file -> $result)" || return $?
}

move_setting_here() {
    move_setting "$1" .
}

# -------------------------------------------------
# Application
# -------------------------------------------------

# option
while getopts 'Cv:h-:' flag; do
    case "${flag}" in
        C) source ./color.sh true ;;
        v) version=$OPTARG ;;
        h)
            echo "
./upload.sh -[C] -[v<VERSION>] -[h]

Available option:
    ${C_FG_1}-${C_UL}C${C_RE_UL}          | --${C_UL}color${C_RE_AL}                    - add color
    ${C_FG_1}-${C_UL}v<VERSION>${C_RE_UL} | --${C_UL}version<VERSION>${C_RE_AL}         - upload with spectify version (default=auto)
"
            exit 0
            ;;
        -)
            LONG_OPTARG=
            LONG_OPTVAL=
            NEXT_PARAMS="${!OPTIND}" # OPTIND -> pointer to next parameter
            set_key_value_long_option
            case "${OPTARG}" in
                version*)
                    require_argument
                    version="${LONG_OPTVAL}"
                    ;;
                color*)
                    no_argument
                    source ./color.sh true
                    ;;
                *)
                    if [ "$OPTERR" = 1 ] && [ "${optspec:0:1}" != ":" ]; then
                        echo "Unexpected option '$LONG_OPTARG', run -h for more information"
                        exit 9
                    fi
                    ;;
            esac
            ;;
        *) echo "Unexpected option ${flag} run -h for more information" >&2 ;;
    esac
done

# -----------------------------------------------
# save project
# -----------------------------------------------

[ -f "$1" ] && move_setting_here "$1" && exit 0
[ -d "$1" ] && move_setting_here "$1" && exit 0

file_settings=(
    "$HOME/.bashrc"
    "$HOME/.bash_profile"
    "$HOME/.profile"
    "$HOME/.vimrc"
    "$HOME/.zshrc"
)

for each in "${file_settings[@]}"; do
    echo "upload -> $each"
    move_setting_here "$each"
done

# -----------------------------------------------
# extra help
# -----------------------------------------------

# echo "complete -- log at 'out.log'"

# echo $(date) >>out.log
