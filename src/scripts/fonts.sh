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


cd "$(dirname "$0")"

only_font() {
    choose "powerline font" && powerline_font
    choose "fira code font" && firacode_font

    return 0
}

powerline_font() {
    file="${TEMP}/fonts"
    git clone https://github.com/powerline/fonts.git --depth=1 "$file"
    cd "$file"
    ./install.sh
    [ -n "$file" ] && rm -rf "$file"
}

firacode_font() {
    check_brew
    run_brew cask install font-fira-code
}