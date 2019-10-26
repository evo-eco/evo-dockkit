#!/usr/bin/env bash

SHARED_HOME=$(realpath $( cd "${BASH_SOURCE[0]%/*}" && pwd ))

DEVKIT_REPO_CLONE_FOLDER=evo-devkit
DEVKIT_HOME=$(realpath "$SHARED_HOME/$DEVKIT_REPO_CLONE_FOLDER")

DEVKIT_DOCKER_IMAGE_IDENTIFIER=evo/bins:devkit
DEVKIT_DOCKER_COMPOSE_FILE=$(realpath "$SHARED_HOME/docker-compose.yml")

source $(realpath "$SHARED_HOME/../../lib/functions-util.sh")
source $(realpath "$SHARED_HOME/../../lib/functions-docker.sh")

## TODO: MOVE THIS INTO THE ACTUAL DEVKIT. NO NEED TO DUPLICATE THESE HELPERS EVERYWHERE WE NEED TO USE THEM.

function build_devkit_image() {
    # TODO: absolute pathing

    ${DEVKIT_HOME}/devkit/build.sh

    docker build . -t ${DEVKIT_DOCKER_IMAGE_IDENTIFIER}

}

function is_devkit_exists_repo() {

    [[ -d ${DEVKIT_HOME} ]] && echo "true" || echo "false"

}

function ensure_devkit_exists_repo() {

    if [[ $(is_devkit_exists_repo) == "false" ]]; then
        git clone git@github.com:evo-eco/evo-devkit.git ${DEVKIT_HOME}
    fi

}

function is_devkit_exists_docker_image() {

    echo $(is_docker_image_existing ${DEVKIT_DOCKER_IMAGE_IDENTIFIER})

}

function ensure_devkit_exists_image() {

    if [[ $(is_devkit_exists_docker_image) == "false" ]]; then
        build_devkit_image
    fi

}

function is_devkit_exists() {

    echo $( [[ $(is_devkit_exists_repo) == "true" && $(is_devkit_exists_docker_image) == "true" ]] && echo "true" || echo "false")

}

function ensure_devkit_exists() {

    ensure_devkit_exists_repo

    ensure_devkit_exists_image

}

function is_devkit_up() {

    test_string_nonempty $(docker-compose -f ${DEVKIT_DOCKER_COMPOSE_FILE} ps -q )

}

function ensure_devkit_up() {

    ensure_devkit_exists

    [[ $(is_devkit_up) == "false" ]] && docker-compose -f ${DEVKIT_DOCKER_COMPOSE_FILE} up -d;

}

function is_devkit_down() {

    [[ ! $(is_devkit_up) == "true" ]] && echo "true" || echo "false";

}

function ensure_devkit_down() {

    docker-compose -f ${DEVKIT_DOCKER_COMPOSE_FILE} down;

}

function echo_devkit_status() {

    echo "DEVKIT_DOCKER_IMAGE_IDENTIFIER: $DEVKIT_DOCKER_IMAGE_IDENTIFIER"
    echo
    echo "is_devkit_exists_docker_image: $(is_devkit_exists_docker_image)"
    echo "is_devkit_exists_repo: $(is_devkit_exists_repo)"
    echo "is_devkit_exists: $(is_devkit_exists)"
    echo
    echo "is_devkit_up: $(is_devkit_up)"
    echo "is_devkit_down: $(is_devkit_down)"
    echo
#    echo "ensure_devkit_exists_repo: $(ensure_devkit_exists_repo)"
#    echo "ensure_devkit_exists_image: $(ensure_devkit_exists_image)"
#    echo "ensure_devkit_exists: $(ensure_devkit_exists)"
}

echo_devkit_status