#!/usr/bin/env bash

REPO_HOME=$( cd "${BASH_SOURCE[0]%/*}" && cd .. && pwd )
DEVKIT_HOME=$( cd "${BASH_SOURCE[0]%/*}" && cd ../devkit && pwd )

PARENT_COMMAND=$(ps -o comm= $PPID)

PATH_DEVKIT_CONF=$(realpath "$DEVKIT_HOME/conf")

NAME_DEVKIT="devkit"
NAME_DOCKER_SERVICE_BOX="box"
NAME_DOCKER_CONTAINER_BOX="${NAME_DEVKIT}_${NAME_DOCKER_SERVICE_BOX}"

NAME_DOCKER_IMAGE_SYSD="evo/devkit:sysd"
NAME_DOCKER_IMAGE_SSHD="evo/devkit:sshd"
NAME_DOCKER_IMAGE_BOX="evo/devkit:box"

FILE_AUTHORIZED_KEYS=$(realpath "${DEVKIT_HOME}/conf/authorized_keys")
FILE_DOCKER_COMPOSE=$(realpath "${DEVKIT_HOME}/docker-compose.yml")