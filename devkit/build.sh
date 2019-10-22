#!/usr/bin/env bash

set -e

# make it so you can run from any directory: https://stackoverflow.com/a/16349776/726368
#cd "${0%/*}"

pushd "${BASH_SOURCE[0]%/*}" > /dev/null

source "../lib/variables.sh"

# colors + exception traps
import util/

# required for logging (bleh, per file)
namespace evo

Log " >>>> BUILD: ./docker/build.sh ($(pwd))"
./docker/build.sh

popd > /dev/null

echo ""
echo ""

DEVKIT_IMAGE_ID_LIST=$(docker images -q -f reference=evo/devkit)
DEVKIT_IMAGE_ID_SYSD=$(docker images -q -f reference=evo/devkit:sysd)
DEVKIT_IMAGE_ID_SSHD=$(docker images -q -f reference=evo/devkit:sshd)
DEVKIT_IMAGE_ID_BOX=$(docker images -q -f reference=evo/devkit:box)

DEVKIT_CONTAINER_ID_BOX=$(docker ps -q -f name=${NAME_DOCKER_CONTAINER_BOX})

function ref() {
    echo "$(UI.Color.Green)$1$(UI.Color.Default)";
}

echo
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo " Welcome to the jungle."
echo ""
echo "  [ IMAGES ]"
echo "      - ../devkit/docker/vpnd/Dockerfile                          [ imageId=$(ref ${DEVKIT_IMAGE_ID_BOX}) ]"
echo "      - ../devkit/docker/vpnd/build.sh                            [ docker images -f reference=evo/devkit:vpnd ]"
echo ""
echo "      - ../devkit/docker/sshd/Dockerfile                          [ imageId=$(ref ${DEVKIT_IMAGE_ID_SSHD}) ]"
echo "      - ../devkit/docker/sshd/build.sh                            [ docker images -f reference=evo/devkit:sshd ]"
echo ""
echo "      - ../devkit/docker/sysd/Dockerfile                          [ imageId=$(ref ${DEVKIT_IMAGE_ID_SYSD}) ]"
echo "      - ../devkit/docker/sysd/build.sh                            [ docker images -f reference=evo/devkit:sysd ]"
echo ""
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'