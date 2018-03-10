#!/usr/bin/env bash

# set -x #DEBUG - Display commands and their arguments as they are executed.
# set -v #VERBOSE - Display shell input lines as they are read.
# set -n #EVALUATE - Check syntax of the script but don't execute.

#/ -------------------------------------------------
#/ Description:  This is index of the setting script
#/               Every subscript / subcommand must run by ths file first.
#/ Create by:    Kamontat Chantrachirathumrong
#/ Since:        10 Mar 2561
#/ -------------------------------------------------
#/ Version:      0.0.1  -- alpha version
#/ -------------------------------------------------
#/ Error code    1      -- unhandle error
#/               2      -- file not found
#/               3      -- wrong OS
#/ -------------------------------------------------
#/ Bug:          no exist
#/ -------------------------------------------------

cd "$(dirname "$0")"
# cd "$(dirname "$(realpath "$0")")"

[ -f "../../_location.sh" ] && source "../../_location.sh" || exit 2
[ -f "${UTILS}/lowest_level.utils.sh" ] && source "${UTILS}/lowest_level.utils.sh" || exit 2

[ -f "${CONSTANTS}/constants.sh" ] && source "${CONSTANTS}/constants.sh" || throw "constants not found" 2

[ -f "${UTILS}/opt.utils.sh" ] && source "${UTILS}/opt.utils.sh" || throw "opt utils not found" 2
[ -f "${UTILS}/setting.utils.sh" ] && source "${UTILS}/setting.utils.sh" || throw "setting utils not found" 2
[ -f "${UTILS}/command.utils.sh" ] && source "${UTILS}/command.utils.sh" || throw "command utils not found" 2
[ -f "${UTILS}/installation.utils.sh" ] && source "${UTILS}/installation.utils.sh" || throw "install utils not found" 2
[ -f "${UTILS}/checker.utils.sh" ] && source "${UTILS}/checker.utils.sh" || throw "checker utils not found" 2

[ -f "${SCRIPTS}/fonts.sh" ] && source "${SCRIPTS}/fonts.sh" || throw "font not found" 2
[ -f "${SCRIPTS}/brew.sh" ] && source "${SCRIPTS}/brew.sh" || throw "brew not found" 2
[ -f "${SCRIPTS}/setting.sh" ] && source "${SCRIPTS}/setting.sh" || throw "setting not found" 2

# -------------------------------------------------
# Constants
# -------------------------------------------------

b=false
f=false
m=false

# -------------------------------------------------
# App logic
# -------------------------------------------------

while getopts 'bfhms:u:-:' flag; do
    case "${flag}" in
        b) b=true ;;
        f) f=true ;;
        m) m=true ;;
        a) b=true && 
            f=true && 
            m=true ;;
        h) help "${SCRIPTS}/index.sh" && exit 0 ;;
        s) export shell="$OPTARG" ;;
        u) export user="$OPTARG" ;;
        -)
            unset LONG_OPTARG LONG_OPTVAL
            NEXT_PARAMS="${!OPTIND}" # OPTIND -> pointer to next parameter
            set_key_value_long_option
            case "${OPTARG}" in
                help)
                    no_argument
                    help "$0" && exit 0 
                    ;;
                only-font)
                    no_argument
                    f=true
                    ;;
                only-brew)
                    no_argument
                    b=true
                    ;;
                user*)
                    require_argument
                    export user="$LONG_OPTVAL"
                    ;;
                shell*)
                    require_argument
                    export shell="$LONG_OPTVAL"
                    ;;
                *)
                    if [ "$OPTERR" = 1 ] && [ "${optspec:0:1}" != ":" ]; then
                        echo "Unexpected option '$LONG_OPTARG', run -h or --help for more information" >&2
                        exit 9
                    fi
                    ;;
            esac
            ;;
        *) echo "Unexpected option ${flag}, run '-h' or '--help' for more information" >&2 ;;
    esac
done

check_user # must be root

$m && only_mac_setting
$f && only_font
$b && only_brew 