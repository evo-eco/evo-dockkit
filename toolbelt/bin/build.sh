#!/usr/bin/env bash

set -e

SHARED_HOME=$(realpath $( cd "${BASH_SOURCE[0]%/*}" && pwd ))

pushd ${SHARED_HOME}

source ../tools.sh

build_devkit_image

popd