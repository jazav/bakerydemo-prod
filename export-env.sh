#!/bin/sh

## Usage:
##   . ./export-env.sh

unamestr=$(uname)

if [ "$unamestr" = 'Linux' ]; then
  #  export $(grep -v '^#' .env | xargs -d '\n')
  export $(grep -v '^#' .env | xargs)
echo 'variables are exported on Linux'

elif [ "$unamestr" = 'Darwin' ]; then
  export $(grep -v '^#' .env | xargs -I '\n')
echo 'variables are exported on Macos'

elif [ "$unamestr" = 'FreeBSD' ]; then
  export $(grep -v '^#' .env | xargs -0)
echo 'variables are exported on FreeBSD'
fi
