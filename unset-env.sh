#!/bin/sh

## Usage:
##   . ./unset-env.sh

unamestr=$(uname)

if [ "$unamestr" = 'Darwin' ]; then
  unset $(grep -v '^#' .env | sed -E 's/(.*)=.*/\1/' | xargs  -I '\n')
  echo 'variables are unset on Macos'
else
  unset $(grep -v '^#' .env | sed -E 's/(.*)=.*/\1/' | xargs)
  echo 'variables are unset on Linux'
fi

