#!/usr/bin/env bash

set -e

#        # need IntelliJ to know about these vars
#        {
#            # make it so you can run from any directory: https://stackoverflow.com/a/16349776/726368
#            pushd "${0%/*}" > /dev/null
#            source ../vars.sh
#            popd > /dev/null
#        }

SHARED=$(realpath $(cd "${BASH_SOURCE[0]%/*}" && pwd))

pushd "${SHARED}" > /dev/null
source ../vars.sh
source functions-all.sh
popd > /dev/null

## BOOTSTRAP ##
source "$SHARED/bash-oo-framework/lib/oo-bootstrap.sh"

import util/

namespace evo

## ADD OUTPUT OF "evo" TO DELEGATE STDERR
Log::AddOutput evo CUSTOM

Log::AddOutput debug DEBUG
Log::AddOutput default DEBUG
Log::AddOutput error ERROR

Log::AddOutput devkit DEBUG
Log::AddOutput devkit-sysd DEBUG
Log::AddOutput devkit-sshd DEBUG
Log::AddOutput devkit-vpnd DEBUG
Log::AddOutput devkit-box DEBUG
Log::AddOutput devkit-bin DEBUG

to_devkit_home_absolute() {
    echo $(realpath "${PATH_REPO_HOME}/$1")
}

run_devkit_home_relative_script() {
    FILE_NAME=$1
    ABSOLUTE_FILE_NAME=$(to_devkit_home_absolute ${FILE_NAME})

    exec ${ABSOLUTE_FILE_NAME}
}

run_docker_build_script() {
    NAME=$1
    TAG=$2
    FILE_NAME="images/$NAME/build.sh"
    ABSOLUTE_FILE_NAME=$(to_devkit_home_absolute ${FILE_NAME})

    echo "exec ${ABSOLUTE_FILE_NAME} ${TAG}"

    exec ${ABSOLUTE_FILE_NAME} ${TAG}
}

# doesn't work?
#docker-ip() {
#  docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@"
#}

announce_env() {
    echo

    subject=env Log ""
    subject=env Log "DEVKIT_HOME: ${PATH_REPO_HOME}"
    subject=env Log "REPO_HOME: ${PATH_REPO_HOME}"
    subject=env Log ""

    echo
}