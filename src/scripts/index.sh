#!/usr/bin/env bash

# set -x #DEBUG - Display commands and their arguments as they are executed.
# set -v #VERBOSE - Display shell input lines as they are read.
# set -n #EVALUATE - Check syntax of the script but don't execute.

#/ -------------------------------------------------
#/ Title:        Index script
#/ -------------------------------------------------
#/ Description:  This is index of the setting script
#/               Every subscript must run by this file.
#/ -------------------------------------------------
#/ Options:
#/      --help             | -h        >> for help command
#/      --user             | -U        >> (required) 'specify' user
#/      --mail             | -M        >> (required) 'specify' mail
#/      --shell            | -S        >> (optional) 'specify' shell
#/      --use-cache        | -C        >> don't download, if file exist
#/      --font             | -f        >> for run 'font' setting only
#/      --mac-setting      | -m        >> for run 'mac' setting only
#/      --application      | -p        >> for run 'application' setting only
#/      --only-application | -P        >> 'specify' txt file name for load application
#/      --all              | -a        >> for every setting
#/      --yes              | -y        >> always install every thing
#/ -------------------------------------------------
#/ Example:
#/      sudo ./index.sh -aU $(whoami)  >> run all settings with sudo
#/      ./index.sh --help              >> for helping command
#/      ./index.sh --font    		   >> run only 'font' setting
#/ -------------------------------------------------
#/ Create by:
#/      Kamontat Chantrachirathumrong
#/ Since:
#/      10 Mar 2561
#/ -------------------------------------------------
#/ Version:
#/      0.1.0-b1  -- beta version
#/      0.2.0     -- new application installer
#/ -------------------------------------------------
#/ Error code
#/      1         -- unhandle error
#/      2         -- file not found
#/      3         -- wrong OS
#/      5         -- required command not exist
#/ -------------------------------------------------
#/ Bug:           no exist
#/ -------------------------------------------------

cd "$(dirname "$0")"

[ -f "../../_location.sh" ] && source "../../_location.sh" || exit 2
[ -f "${UTILS}/lowest_level.utils.sh" ] && source "${UTILS}/lowest_level.utils.sh" || exit 2

[ -f "${CONSTANTS}/command.constants.sh" ] && source "${CONSTANTS}/command.constants.sh" || throw "command constants not found" 2
[ -f "${CONSTANTS}/constants.sh" ] && source "${CONSTANTS}/constants.sh" || throw "constants not found" 2

[ -f "${UTILS}/opt.utils.sh" ] && source "${UTILS}/opt.utils.sh" || throw "opt utils not found" 2
[ -f "${UTILS}/setting.utils.sh" ] && source "${UTILS}/setting.utils.sh" || throw "setting utils not found" 2
[ -f "${UTILS}/command.utils.sh" ] && source "${UTILS}/command.utils.sh" || throw "command utils not found" 2
[ -f "${UTILS}/installation.utils.sh" ] && source "${UTILS}/installation.utils.sh" || throw "installation utils not found" 2
[ -f "${UTILS}/checker.utils.sh" ] && source "${UTILS}/checker.utils.sh" || throw "checker utils not found" 2

[ -f "${SCRIPTS}/fonts.sh" ] && source "${SCRIPTS}/fonts.sh" || throw "font not found" 2
[ -f "${SCRIPTS}/applications.sh" ] && source "${SCRIPTS}/applications.sh" || throw "applications not found" 2
[ -f "${SCRIPTS}/setting.sh" ] && source "${SCRIPTS}/setting.sh" || throw "setting not found" 2
# [ -f "${SCRIPTS}/application.sh" ] && source "${SCRIPTS}/application.sh" || throw "application not found" 2

# -------------------------------------------------
# Constants
# -------------------------------------------------

h=false

d=false
f=false
m=false
p=false
s=false

export ALWAYS_YES=false
export account

# -------------------------------------------------
# App logic
# -------------------------------------------------

while getopts 'aCfhmM:pP:S:U:wxy-:' flag; do
	case "${flag}" in
	p) p=true ;;
	P) p="$OPTARG" ;;
	f) f=true ;;
	m) m=true ;;
	s) s=true ;;
	a) p=true &&
		f=true &&
		m=true &&
		s=true ;;
	h) h=true ;;
	C) export cache=true ;;
	S) export shell="$OPTARG" ;;
	U) export user="$OPTARG" ;;
	M) export account="$OPTARG" ;;
	w) set -x && DEBUG=true ;;
	x) DEBUG=true ;;
	y) ALWAYS_YES=true ;;
	-)
		unset LONG_OPTARG LONG_OPTVAL
		NEXT_PARAMS="${!OPTIND}" # OPTIND -> pointer to next parameter
		set_key_value_long_option
		case "${OPTARG}" in
		help)
			no_argument
			h=true
			;;
		font)
			no_argument
			f=true
			;;
		setting)
			no_argument
			s=true
			;;
		mac-setting)
			no_argument
			m=true
			;;
		application)
			no_argument
			p=true
			;;
		only-application*)
			require_argument
			p="$LONG_OPTVAL"
			;;
		all)
			no_argument
			p=true && f=true && m=true && s=true
			;;
		user*)
			require_argument
			export user="$LONG_OPTVAL"
			;;
		mail*)
			require_argument
			export account="$LONG_OPTVAL"
			;;
		shell*)
			require_argument
			export shell="$LONG_OPTVAL"
			;;
		use-cache)
			no_argument
			export cache=true
			;;
		verbose)
			no_argument
			set -x && DEBUG=true
			;;
		debug)
			no_argument
			DEBUG=true
			;;
		yes)
			no_argument
			ALWAYS_YES=true
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

if $h; then
	file="${SCRIPTS}/index.sh"

	$m && file="${SCRIPTS}/setting.sh"
	$f && file="${SCRIPTS}/fonts.sh"
	$p && file="${SCRIPTS}/applications.sh"

	help "$file" && exit 0
fi

check_user # must be root

[[ $p == true ]] && only_applications
$s && only_other_setting
$m && only_mac_setting
$f && only_font
[[ $p != true ]] && [[ $p != false ]] && specify_applications "$p"
