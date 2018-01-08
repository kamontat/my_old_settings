#!/bin/bash

# set -x # debug
set -e # force exit if nonzero code

cd "$(dirname "$0")" || exit 1

cache_folder="caches/"
cache_postfix="cache"

[ ! -d "$cache_folder" ] &&
    mkdir "$cache_folder" 2>/dev/null

dependencies_folder="dependencies/"
homebrew_dep="home_brew_list.txt"
python_dep="python_list.txt"
npm_dep="node_list.txt"

validate_version() {
    local t
    t=$(echo "$1" | grep -o -E "v([^.a-zA-Z ]+)")
    [[ $1 != "$t" ]] && echo "$1 is not valid version" && exit 1
    return 0
}

# must be v1 v2 v3 ...
# without any dot prefix or more
t="$(git tag --list --sort v:refname)"
old_version="${t##*$'\n'}"
validate_version "$old_version"

version="v$((${old_version##v} + 1))"
validate_version "$version"

auto=false

echo "update -> $old_version to $version"

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

# @explain    - get name of the path
# @params - 1 - the path
# @return     - name of folder and fil eon the path
get_file_name() {
    echo "${1##*/}"
}

# @explain    - save cache (as DayMonthYearHour)
# @param - 1 - file or folder
cache() {
    local t
    t="$(dirname "$1")/$cache_folder${1##*/}"
    # echo "$t"
    copy "$1" "$t.$(date +%d%m%y%H).$cache_postfix"
}

# @explain    - try to move setting file to location
# @params - 1 - setting file / folder
#           2 - result location
move_setting() {
    file="$1"
    result="$2"

    # echo "(1) - $file"
    # echo "(1) - $result"
    [ -d "$result" ] &&
        result="$result/${file##*/}"
    [[ ${file##*/} == "${result##*/}" ]] &&
        [ -d "$result" ] &&
        result="$(dirname "$result")"
    # echo "(2) - $file"
    # echo "(2) - $result"
    # return 0

    # copy
    if [ ! -f "$result" ]; then
        copy "$file" "$result" && echo "${C_FG_1}copy${C_RE_AL} ($file -> $result)" || return $?
        return 0
    fi
    # replace
    cache "$result" &&
        copy "$file" "$result" &&
        echo "${C_FG_1}replaced${C_RE_AL} ($file -> $result)" || return $?
}

move_setting_here() {
    move_setting "$1" "."
}

help() {
    echo "
./upload.sh -[C] -[v<VERSION>] -[h]

Available option:
    ${C_FG_1}-${C_UL}C${C_RE_UL}          | --${C_UL}color${C_RE_AL}                    - add color
    ${C_FG_1}-${C_UL}A${C_RE_UL}          | --${C_UL}auto${C_RE_AL}                     - auto push result to github
    ${C_FG_1}-${C_UL}v<VERSION>${C_RE_UL} | --${C_UL}version<VERSION>${C_RE_AL}         - upload with spectify version (default=auto)
    ${C_FG_1}-${C_UL}h${C_RE_UL}          | --${C_UL}help${C_RE_AL}                     - show this command
"
}

# -------------------------------------------------
# Application
# -------------------------------------------------

# option
while getopts 'ACv:h-:' flag; do
    case "${flag}" in
        A) auto=true ;;
        C) source ./color.sh true ;;
        v) version=$OPTARG ;;
        h)
            help
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
                auto)
                    no_argument
                    auto=true
                    ;;
                color)
                    no_argument
                    source ./color.sh true
                    ;;
                help)
                    no_argument
                    help
                    exit 0
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
    # "$HOME/.vimrc"
    "$HOME/.zshrc"
    "$HOME/.inputrc"
    "$HOME/.bashrc"
    "$HOME/.bash_profile"
    "$HOME/.profile"
    # "$HOME/.vim"
    "$HOME/.gitconfig"
    "$HOME/.tmux.conf"
    "$HOME/.config/neofetch"
    # "$HOME/.config/nvim/init.vim"
    "$HOME/.SpaceVim.d"
    "$HOME/.my-zsh"
)

for each in "${file_settings[@]}"; do
    ret=1
    test -f "$each" &&
        printf "upload -> " &&
        move_setting_here "$each" && ret=0

    test -d "$each" &&
        printf "upload -> " &&
        move_setting_here "$each" && ret=0

    if [ $ret -ne 0 ]; then
        echo "${C_FG_2}no-exist${C_RE_AL} -> $each"
    fi
done

# setup brew
echo "upload -> ${C_FG_1}homebrew${C_RE_AL}"
brew list | while read -r cask; do echo "$cask"; done >"$dependencies_folder$homebrew_dep"

# setup pip
echo "upload -> ${C_FG_1}pip${C_RE_AL}"
pip freeze >"$dependencies_folder$python_dep"

# setup npm
echo "upload -> ${C_FG_1}npm${C_RE_AL}"
npm ls -g --depth=0 | tr -d "├" | tr -d "└" | tr -d "─" | tr -d " " >"$dependencies_folder$npm_dep"

if $auto; then
    # setup git and github
    echo ">> commit..."
    git add .
    git commit -m "🔖 Dump version: $version"

    echo ">> tag: $version"
    git tag $version

    # update data in github
    echo ">> upload data to github.."
    git push
    git push --tag
fi
