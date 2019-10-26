#!/usr/bin/env bash

set -e

SHARED_HOME=$(realpath $( cd "${BASH_SOURCE[0]%/*}" && pwd ))

pushd ${SHARED_HOME}

source ../tools.sh

ensure_devkit_down

docker image rm --force $( get_docker_image_ids ${DEVKIT_DOCKER_IMAGE_IDENTIFIER} );

popd;
