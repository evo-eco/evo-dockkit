#!/usr/bin/env bash

FILE_AUTHORIZED_KEYS=./authorized_keys

# make it so you can run from any directory: https://stackoverflow.com/a/16349776/726368
cd "${0%/*}"

source "./lib/variables.sh"

# colors + exception traps
import util/

# required for logging (bleh, per file)
namespace evo

DEVKIT_IMAGE_ID_LIST=$(docker images -q -f reference=evo/devkit)
DEVKIT_IMAGE_ID_SYSD=$(docker images -q -f reference=evo/devkit:sysd)
DEVKIT_IMAGE_ID_SSHD=$(docker images -q -f reference=evo/devkit:sshd)
DEVKIT_IMAGE_ID_VPND=$(docker images -q -f reference=)

DEVKIT_CONTAINER_ID_VPND=$(docker ps -q -f name=${NAME_DOCKER_CONTAINER_VPND})

Log "safely_remove_docker_container ${NAME_DOCKER_CONTAINER_VPND}"
safely_remove_docker_container ${NAME_DOCKER_CONTAINER_VPND}

Log "safely_clear_docker_image_cache ${NAME_DOCKER_IMAGE_VPND}"
safely_clear_docker_image_cache ${NAME_DOCKER_IMAGE_VPND}