#!/usr/bin/env bash

# set -x #DEBUG - Display commands and their arguments as they are executed.
# set -v #VERBOSE - Display shell input lines as they are read.
# set -n #EVALUATE - Check syntax of the script but don't execute.


#/ -------------------------------------------------
#/ Description:  Only for commit code, in specify commit message
#/ Create by:    Kamontat Chantrachirathumrong
#/ Since:        10 Mar 2561
#/ -------------------------------------------------

printf "which to commit.. 
Header [script|util|constant|resource|command]? "
read -r header
echo 

printf "which to commit.. 
Subheader (file or multiple or none)? "
read -r subheader
echo 

printf "which to commit.. 
Type [fix|code|typo|docs|new|improve|enhance]? "
read -r type
echo 

printf "which to commit.. 
Message? "
read -r msg
echo 

git commit -m "(${header}-${subheader})-($type):
$msg
"