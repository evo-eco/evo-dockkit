#!/usr/bin/env bash

PARAM_PATH=$1
DEFAULT_PATH=$( cd "${BASH_SOURCE[0]%/*}" && cd .. && pwd )

YOUR_ABSOLUTE_PATH=$( [[ -z ${PARAM_PATH} ]] && echo ${DEFAULT_PATH} || echo ${PARAM_PATH} )

MY_PATH=$( cd "${BASH_SOURCE[0]%/*}" && pwd )
LIB_PATH=$(realpath "$MY_PATH/toolbelt")
BIN_PATH=$(realpath "$LIB_PATH/bin")

echo "installing to ${YOUR_ABSOLUTE_PATH}"

# ln source destination
ln -s "$LIB_PATH/toolbelt.sh" "$YOUR_ABSOLUTE_PATH/toolbelt.sh"