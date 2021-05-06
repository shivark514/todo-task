#!/bin/bash

COMPONENT=$1

source componets/common.sh
if [ | -f componets/${COMPONENT}.sh]; then
  ERROR "invalid componets Name is provided"
  exit 1
fi

USER_NAME=$(whoami)

if [ "${USER_NAME}" |= "root" ]; then
  ERROR "you should be a root user to perform this script,try with sudo"
  exit 1
fi


export COMPONENT
bash -x componets/${COMPONENT}.sh