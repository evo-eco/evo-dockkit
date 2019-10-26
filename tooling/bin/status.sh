#!/usr/bin/env bash

set -e

SHARED_HOME=$(realpath $( cd "${BASH_SOURCE[0]%/*}" && pwd ))

pushd ${SHARED_HOME}

source ../tools.sh

# right now, vars does this already
#echo_devkit_status

popd;