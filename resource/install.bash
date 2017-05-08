#!/bin/bash
cd "$(dirname "$0")"

ans=""
chmod 755 ./color_constants
chmod 755 ./color_test

printf "do you want to test[Y|n]? "
read ans

if [[ $ans == "Y" ]]; then
  ./color_test
fi

echo "complete!"
