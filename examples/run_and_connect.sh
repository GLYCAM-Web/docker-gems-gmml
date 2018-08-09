#!/usr/bin/env bash
# Created by: Davis Templeton 2018-08-09

#########################################################
## This script is used to run and connect into the     ##
## GEMS/GMML Docker container with your host mounted   ##
## directory.                                          ##
#########################################################
PREFIX=${USER}

docker run \
  -it --rm \
  --name ${PREFIX}_gems-gmml \
  -v $(pwd)/gems:/programs/gems \
  glycamweb/gems-gmml
