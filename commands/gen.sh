#!/usr/bin/env bash

# set -x #DEBUG - Display commands and their arguments as they are executed.
# set -v #VERBOSE - Display shell input lines as they are read.
# set -n #EVALUATE - Check syntax of the script but don't execute.


#/ -------------------------------------------------
#/ Description:  generate bash script, 'Input 1 parameter is file location'
#/ Create by:    Kamontat Chantrachirathumrong
#/ Since:        10 Mar 2561
#/ -------------------------------------------------

bash <(curl -sL https://github.com/Template-Generating/script-genrating/raw/master/template.sh ) -f "$1"