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

announce_evo

echo
Log " >>>> BUILD: ./docker/build.sh ($(pwd))"
./docker/build.sh

popd > /dev/null

echo ""
echo ""

DEVKIT_IMAGE_ID_LIST=$(docker images -q -f reference=evo/devkit)
DEVKIT_IMAGE_ID_SYSD=$(docker images -q -f reference=evo/devkit:sysd)
DEVKIT_IMAGE_ID_SSHD=$(docker images -q -f reference=evo/devkit:sshd)
DEVKIT_IMAGE_ID_VPND=$(docker images -q -f reference=evo/devkit:vpnd)
DEVKIT_IMAGE_ID_BOX=$(docker images -q -f reference=evo/devkit:box)
DEVKIT_IMAGE_ID_BIN=$(docker images -q -f reference=evo/devkit:bin)

DEVKIT_CONTAINER_ID_BOX=$(docker ps -q -f name=${NAME_DOCKER_CONTAINER_BOX})

function ref() {
    echo "$(UI.Color.Green)$1$(UI.Color.Default)";
}

announce_evo

echo
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo ""
echo "  [ IMAGES ]"
echo ""
echo "      - ../devkit/docker/$(ref bin)/Dockerfile                           [ imageId=$(ref ${DEVKIT_IMAGE_ID_BIN}) ]"
echo "      - ../devkit/docker/$(ref bin)/build.sh                             [ docker images -f reference=evo/devkit:bin ]"
echo ""
echo "      - ../devkit/docker/$(ref box)/Dockerfile                           [ imageId=$(ref ${DEVKIT_IMAGE_ID_BOX}) ]"
echo "      - ../devkit/docker/$(ref box)/build.sh                             [ docker images -f reference=evo/devkit:box ]"
echo ""
echo "      - ../devkit/docker/$(ref vpnd)/Dockerfile                          [ imageId=$(ref ${DEVKIT_IMAGE_ID_VPND}) ]"
echo "      - ../devkit/docker/$(ref vpnd)/build.sh                            [ docker images -f reference=evo/devkit:vpnd ]"
echo ""
echo "      - ../devkit/docker/$(ref sshd)/Dockerfile                          [ imageId=$(ref ${DEVKIT_IMAGE_ID_SSHD}) ]"
echo "      - ../devkit/docker/$(ref sshd)/build.sh                            [ docker images -f reference=evo/devkit:sshd ]"
echo ""
echo "      - ../devkit/docker/$(ref sysd)/Dockerfile                          [ imageId=$(ref ${DEVKIT_IMAGE_ID_SYSD}) ]"
echo "      - ../devkit/docker/$(ref sysd)/build.sh                            [ docker images -f reference=evo/devkit:sysd ]"
echo ""
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo
echo
