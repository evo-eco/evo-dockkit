#!/usr/bin/env bash

# make it so you can run from any directory: https://stackoverflow.com/a/16349776/726368
cd "${0%/*}"

source ../lib/shared.sh

# colors + exception traps
import util/

# required for logging (bleh, per file)
namespace evo

DEVKIT_IMAGE_ID_LIST=$(docker images -q -f reference=${DEVKIT_REF_PREFIX})

DEVKIT_IMAGE_ID_SYSD=$(docker images -q -f reference=${DEVKIT_REF_SYSD})
DEVKIT_IMAGE_ID_SSHD=$(docker images -q -f reference=${DEVKIT_REF_SSHD})
DEVKIT_IMAGE_ID_VPND=$(docker images -q -f reference=${DEVKIT_REF_VPND})
DEVKIT_IMAGE_ID_BOX=$(docker images -q -f reference=${DEVKIT_REF_BOX})
DEVKIT_IMAGE_ID_BIN=$(docker images -q -f reference=${DEVKIT_REF_BIN})

DEVKIT_CONTAINER_ID_VPND=$(docker ps -q -f name=${NAME_DOCKER_CONTAINER_VPND})

echo_keyvalue "DEVKIT_IMAGE_ID_SYSD (${DEVKIT_REF_SYSD})" ${DEVKIT_IMAGE_ID_SYSD}
echo_keyvalue "DEVKIT_IMAGE_ID_SSHD (${DEVKIT_REF_SSHD})" ${DEVKIT_IMAGE_ID_SSHD}
echo_keyvalue "DEVKIT_IMAGE_ID_VPND (${DEVKIT_REF_VPND})" ${DEVKIT_IMAGE_ID_VPND}
echo_keyvalue "DEVKIT_IMAGE_ID_BOX (${DEVKIT_REF_BOX})" ${DEVKIT_IMAGE_ID_BOX}
echo_keyvalue "DEVKIT_IMAGE_ID_BIN (${DEVKIT_REF_BIN})" ${DEVKIT_IMAGE_ID_BIN}

echo_keyvalue "DEVKIT_CONTAINER_ID_VPND" ${DEVKIT_CONTAINER_ID_VPND}


#    Log "safely_remove_docker_container ${NAME_DOCKER_CONTAINER_VPND}"
#    safely_remove_docker_container ${NAME_DOCKER_CONTAINER_VPND}
#
#    Log "safely_clear_docker_image_cache ${NAME_DOCKER_IMAGE_VPND}"
#    safely_clear_docker_image_cache ${NAME_DOCKER_IMAGE_VPND}

function echo_fixed_line() {
    local PROC_NAME=$1
    local STATUS=$2

    subject=evo Log $(printf "%-42s%s\n" "$PROC_NAME~" "~[ $STATUS ]" | tr ' ~' '- ')
}

function echo_status_line() {
    echo_fixed_line $1 $([[ -z $2 ]] && echo "$(UI.Color.Green)CLEAN$(UI.Color.Default)" || echo "$(UI.Color.Red)CLEANING$(UI.Color.Default)")
}

function exec_clean() {
    echo_status_line $1 $2
    safely_clear_docker_image_cache $1
}

echo "================================================"
echo "      BEFORE: "
echo "================================================"

docker image ls | grep ${NAME_DEVKIT} || echo "None" && echo

{

    subject=evo Log "------------------------------------------"

    exec_clean ${DEVKIT_REF_BIN} ${DEVKIT_IMAGE_ID_BIN}
    exec_clean ${DEVKIT_REF_BOX} ${DEVKIT_IMAGE_ID_BOX}
    exec_clean ${DEVKIT_REF_VPND} ${DEVKIT_IMAGE_ID_VPND}
    exec_clean ${DEVKIT_REF_SSHD} ${DEVKIT_IMAGE_ID_SSHD}
    exec_clean ${DEVKIT_REF_SYSD} ${DEVKIT_IMAGE_ID_SYSD}

    subject=evo Log "------------------------------------------"

}

echo "================================================"
echo "      AFTER: "
echo "================================================"

docker image ls | grep ${NAME_DEVKIT} || echo "None" && echo

