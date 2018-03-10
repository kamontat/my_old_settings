#!/usr/bin/env bash

# set -x #DEBUG - Display commands and their arguments as they are executed.
# set -v #VERBOSE - Display shell input lines as they are read.
# set -n #EVALUATE - Check syntax of the script but don't execute.

#/ -------------------------------------------------
#/ Title:        Font script
#/ -------------------------------------------------
#/ Description:  Fonts installation
#/               Support 'Powerline' and 'FiraCode' fonts
#/ Create by:    Kamontat Chantrachirathumrong
#/ Since:        11 Mar 2561
#/ -------------------------------------------------
#/ Version:      1.0.0  -- finish first version
#/ -------------------------------------------------
#/ Error code    1      -- error
#/ -------------------------------------------------
#/ Bug:          no exist
#/ -------------------------------------------------

only_font() {
    choose "powerline font" && _powerline_font
    choose "fira code font" && _firacode_font

    return 0
}

# -------------------------------------------------
# Functions
# -------------------------------------------------

_powerline_font() {
    file="${TEMP}/fonts"
    git clone https://github.com/powerline/fonts.git --depth=1 "$file"
    cd "$file"
    ./install.sh
    [ -n "$file" ] && rm -rf "$file"
}

_firacode_font() {
    check_brew
    run_brew cask install font-fira-code
}