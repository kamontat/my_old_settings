#!/bin/bash
set -e

cd "$(dirname "$0")"

validate_version() {
    regex="^v[0-9]\{1,\}$"
    
    [[ "$1" =~ $regex ]] || exit 1
}

# must be v1 v2 v3 ... 
# without any dot prefix or more
old_version="${$(git tag)##*$'\n'}"
validate_version $old_version

new_version="v$((${version##v} + 1))"
validate_version $new_version

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

    # force copy
    if $always_yes; then
        cache "$result" &&
            copy "$file" "$result" &&
            echo "${C_FG_1}force${C_RE_AL} replace $result" || return $?
        return 0
    fi

    # copy
    if [ ! -f "$result" ]; then
        copy "$file" "$result" && echo "${C_FG_1}copy${C_RE_AL} $file -> $result" || return $?
        return 0
    fi
    # replace
    printf "%s ${C_FG_1}exist!${C_RE_AL} -> Do you want to replace %s?\n [y(es)|n(o)|s(how)] " "$file" "$result"
    read -rn 1 ans
    echo "" # new line
    # replace
    if [[ $ans == "y" ]]; then
        cache "$result" &&
            copy "$file" "$result" &&
            echo "${C_FG_1}replaced${C_RE_AL} ($file -> $result)" || return $?
        # not replace
    elif [[ $ans == "s" ]]; then
        echo 'start """ '
        cat "$file" && echo ""
        echo '""" end.'
        move_setting "$file" "$result"
    else
        echo "use ${C_FG_1}old${C_RE_AL} file ($result)"
    fi
}

# -------------------------------------------------
# Application
# -------------------------------------------------

# option
while getopts 'Cv:h-:' flag; do
    case "${flag}" in
        Y) always_yes=true ;;
        C) source ./color.sh true ;;
        v) new_version=$OPTARG ;;
        u) user=$OPTARG ;;
        h)
            echo "
./install.sh [C] [A|Y|[s<SHELL>|u<USER>]] [h]

Available option:
    ${C_FG_1}-${C_UL}Y${C_RE_UL}        | --${C_UL}yes${C_RE_AL}           - always say 'yes'
    ${C_FG_1}-${C_UL}C${C_RE_UL}        | --${C_UL}color${C_RE_AL}         - add color
    ${C_FG_1}-${C_UL}s<SHELL>${C_RE_UL} | --${C_UL}shell=<SHELL>${C_RE_AL} - input default shell
    ${C_FG_1}-${C_UL}u<USER>${C_RE_UL}  | --${C_UL}user=<USER>${C_RE_AL}   - input default user
"
            exit 0
            ;;
        -)
            LONG_OPTARG=
            LONG_OPTVAL=
            NEXT_PARAMS="${!OPTIND}" # OPTIND -> pointer to next parameter
            set_key_value_long_option
            case "${OPTARG}" in
                yes*)
                    no_argument
                    always_yes=true
                    ;;
                color*)
                    no_argument
                    source ./color.sh true
                    ;;
                shell*)
                    require_argument
                    shell="$LONG_OPTVAL"
                    ;;
                user*)
                    require_argument
                    user="$LONG_OPTVAL"
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

if [[ $1 != "" ]]; then
    copy $1 .
else
    copy ~/.bashrc .
    copy ~/.bash_profile .
    copy ~/.profile .
    copy ~/.vimrc .
    copy ~/.zshrc .
    copy ~/.vim .
    copy ~/.config/nvim/init.vim .
    copy ~/.tmux.conf .
fi

# -----------------------------------------------
# extra help
# -----------------------------------------------

echo "complete -- log at 'out.log'"

echo $(date) >>out.log
