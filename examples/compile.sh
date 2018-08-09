#!/usr/bin/env bash
# Created by: Davis Templeton 2018-08-09

#########################################################
## This script is used to compile your host mounted    ##
## GEMS/GMML inside a container.                       ##
## After running this, if you want to run and connect  ##
## inside the container, then see run_and_connect.sh.  ##
#########################################################
CLEAN=""

if [ "$1" != "" ]; then
  CLEAN="$1"
fi

PREFIX=${USER}

docker run \
  --rm \
  --name ${PREFIX}_gems-gmml \
  -v $(pwd)/gems:/programs/gems \
  glycamweb/gems-gmml \
  bash make.sh ${CLEAN}
