#!/usr/bin/env bash

set -e

source ../tools.sh

ensure_devkit_down

docker image rm --force $( get_docker_image_ids ${DEVKIT_DOCKER_IMAGE_IDENTIFIER} );
