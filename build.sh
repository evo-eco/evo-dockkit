#!/usr/bin/env bash

set -e

# make it so you can run from any directory: https://stackoverflow.com/a/16349776/726368
#cd "${0%/*}"

pushd "${BASH_SOURCE[0]%/*}" > /dev/null

source lib/shared.sh

# colors + exception traps
import util/

# required for logging (bleh, per file)
namespace evo

announce_evo

echo
Log " >>>> BUILD: ./docker/build.sh"

./images/build.sh

popd > /dev/null

echo ""
echo ""

## TODO: replace this with status

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

function fade() {
    echo "$(UI.Color.DarkGray)$1$(UI.Color.Default)";
}

function header() {
    echo "$(UI.Color.Red)$(UI.Color.Bold)$1$(UI.Color.Default)";
}

announce_evo

echo
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo ""
echo "  $(header "[ IMAGES ]")"
echo ""
echo "      [ imageId=$(ref ${DEVKIT_IMAGE_ID_BIN}) ]"
echo "      $(fade "[ docker images -f reference=evo/devkit:bin ]")"
echo ""
echo "      [ imageId=$(ref ${DEVKIT_IMAGE_ID_BOX}) ]"
echo "      $(fade "[ docker images -f reference=evo/devkit:box ]")"
echo ""
echo "      [ imageId=$(ref ${DEVKIT_IMAGE_ID_VPND}) ]"
echo "      $(fade "[ docker images -f reference=evo/devkit:vpnd ]")"
echo ""
echo "      [ imageId=$(ref ${DEVKIT_IMAGE_ID_SSHD}) ]"
echo "      $(fade "[ docker images -f reference=evo/devkit:sshd ]")"
echo ""
echo "      [ imageId=$(ref ${DEVKIT_IMAGE_ID_SYSD}) ]"
echo "      $(fade "[ docker images -f reference=evo/devkit:sysd ]")"
echo ""
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo
echo
