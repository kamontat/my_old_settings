#!/bin/bash

# -----------------------------
# doc type
# -----------------------------

# bold	        Start bold text
# smul	        Start underlined text
# rmul	        End underlined text
# rev	        Start reverse video
# blink	        Start blinking text
# invis	        Start invisible text
# smso	        Start "standout" mode
# rmso	        End "standout" mode
# sgr0	        Turn off all attributes
# setaf <value>	Set foreground color
# setab <value>	Set background color

HELP="
usage: source color_constant.sh
-------------------------------
test: ./color_constant.sh test
-------------------------------
create by Kamontat Chantrachirathumrong
since 09/06/60-16:09 (dd/mm/yy-mm:ss)
version 1.0
"

if [[ $1 == "help" || $1 == "h" ]]; then
    echo "$HELP"
    exit 0
fi

if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
else
    echo "not support tput, use color_raw_constant.sh instead."
    exit 2
fi

# print color bit layout

# echo "$(tput longname)"
# echo "you command line have $ncolors colors"
# echo "  mean your both C_FG_XXX and C_BG_XXX"
# echo "      XXX = 1 - $ncolors"

DEFAULT="C_"
FORGROUND="FG_"
BACKGROUND="BG_"

# temp variable
temp=

# extra word
C_BO="$(tput bold)"
C_DI="$(tput dim)"
C_UL="$(tput smul)"
C_RV="$(tput rev)"
C_SM="$(tput smso)"
C_BL="$(tput blink)"
C_IV="$(tput invis)"

# reset variable
C_RE_AL="$(tput sgr0)"
C_RE_SM="$(tput rmso)"
C_RE_UL="$(tput rmul)"

# example
# programmer=Ines
# declare $programmer="nice gal"
# echo $Ines # echos nice gal

# declare forground color
for (( i=0; i<=ncolors; i++ )); do
    temp="$DEFAULT$FORGROUND$i"
    # echo "$temp"
    declare $temp="$(tput setaf $i)"
done

# declare background color
for (( i=0; i<=ncolors; i++ )); do
    temp="$DEFAULT$BACKGROUND$i"
    declare $temp="$(tput setab $i)"
done

# tester
if [[ $1 == "test" ]]; then
    echo "${C_FG_3}front color 3 ${C_RE_AL}"
    echo "${C_FG_1}front color 1 ${C_RE_AL}"
    echo "${C_FG_7}front color 7 ${C_RE_AL}"
    echo "${C_FG_2}front color 2 ${C_RE_AL}"
    echo "${C_BG_4}back  color 4 ${C_RE_AL}"
    echo "${C_BG_5}back  color 5 ${C_RE_AL}"
    echo "${C_BO}${C_FG_5}BOLD+F5 ${C_RE_AL}"
    echo "${C_BO}${C_FG_7}${C_BG_3}Bold+F7+B3${C_RE_AL}"
    echo "${C_BL}${C_UL}${C_FG_1}Blink+Underline+F1${C_RE_UL} disable underline${C_RE_AL}"
fi
