#!/usr/bin/env bash

set -e

# make it so you can run from any directory: https://stackoverflow.com/a/16349776/726368

{
    pushd "${BASH_SOURCE[0]%/*}" > /dev/null
    source ./paths.sh
    popd > /dev/null

    ## BOOTSTRAP ##
    source "$( cd "${BASH_SOURCE[0]%/*}" && pwd )/./bash-oo-framework/lib/oo-bootstrap.sh"

    pushd "${BASH_SOURCE[0]%/*}" > /dev/null
    source ./functions.sh
    popd > /dev/null
}

import util/exception
import util/

namespace evo

## ADD OUTPUT OF "evo" TO DELEGATE STDERR
Log::AddOutput evo INFO
Log::AddOutput debug DEBUG
Log::AddOutput default DEBUG

Log::AddOutput devkit DEBUG
Log::AddOutput devkit-sysd DEBUG
Log::AddOutput devkit-sshd DEBUG
Log::AddOutput devkit-vpnd DEBUG

to_devkit_home_absolute() {
    echo $(realpath "${DEVKIT_HOME}/$1")
}

run_devkit_home_relative_script() {
    FILE_NAME=$1
    ABSOLUTE_FILE_NAME=$(to_devkit_home_absolute ${FILE_NAME})

    exec ${ABSOLUTE_FILE_NAME}
}

run_docker_build_script() {
    NAME=$1
    FILE_NAME="docker/$NAME/build.sh"
    ABSOLUTE_FILE_NAME=$(to_devkit_home_absolute ${FILE_NAME})

    exec ${ABSOLUTE_FILE_NAME}
}

# doesn't work?
#docker-ip() {
#  docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@"
#}

announce() {
    Log ""
    Log "DEVKIT_HOME: ${DEVKIT_HOME}"
    Log "PROJECT_HOME: ${DEVKIT_HOME}"
    Log ""
    Log "NAME_DOCKER_CONTAINER_VPN: ${NAME_DOCKER_CONTAINER_BOX}"
    Log ""
}