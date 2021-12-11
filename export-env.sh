#!/bin/sh

## Usage:
##   . ./export-env.sh ; $COMMAND
##   . ./export-env.sh ; echo ${MINIENTREGA_FECHALIMITE}

unamestr=$(uname)

if [ "$unamestr" = 'Linux' ]; then

  #  export $(grep -v '^#' .env | xargs -d '\n')
  export $(grep -v '^#' .env | xargs)

elif [ "$unamestr" = 'Darwin' ]; then

  #  export $(grep -v '^#' .env | xargs -d '\n')
  export $(grep -v '^#' .env | xargs)

elif [ "$unamestr" = 'FreeBSD' ]; then

  export $(grep -v '^#' .env | xargs -0)

fi
