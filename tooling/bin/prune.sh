#!/usr/bin/env bash


NUKE_DOCKER_CACHE=false
NUKE_DOCKER_EVERYTHING=false


set -e

# make it so you can run from any directory: https://stackoverflow.com/a/16349776/726368
pushd "${0%/*}" > /dev/null

source ../../images/vars.sh

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

if [[ -z $(docker ps -q) ]]; then
    docker stop $(docker ps -q)
fi

if [[ -z $(docker ps -q -a) ]]; then
    docker rm -f $(docker ps -q -a)
fi

if [[ "${NUKE_DOCKER_CACHE}" = "true" ]]; then
    echo "removing ALL docker images"

    if [[ $(docker images -q -f "dangling=true") ]]; then
        echo "$(UI.Color.Invert)removing dangling images: docker rmi \$(docker images -q -f \"dangling=true\")$(UI.Color.Default)"
        docker rmi -f $(docker images -q -f "dangling=true")
    fi

    if [[ $(docker volume ls  -q --filter dangling=true) ]]; then
        echo "removing dangling volumes: docker volume rm \$(docker volume ls  -q --filter dangling=true)"
        docker volume rm -f $(docker volume ls  -q --filter dangling=true)
    fi

    if [[ "${NUKE_DOCKER_EVERYTHING}" ]]; then
        echo "removing dangling volumes: docker system prune --volumes -a"
        docker system prune --volumes -a -f
    fi
else
    echo "not removing all docker images"
fi

popd > /dev/null