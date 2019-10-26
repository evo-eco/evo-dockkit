#!/usr/bin/env bash

##
#
# usage:
#   all: ./clean.sh
#
##


set -e

# make it so you can run from any directory: https://stackoverflow.com/a/16349776/726368
pushd "${0%/*}" > /dev/null

    source ./vars.sh

    # colors + exception traps
    import util/log

    # required for logging (bleh, per file)
    namespace evo

    {
        function exec_clean() {
            echo_status_line $1 $2
            safely_clear_docker_image_cache $1
        }
    }

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


popd > /dev/null