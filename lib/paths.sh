#!/usr/bin/env bash

DEVKIT_HOME=$( cd "${BASH_SOURCE[0]%/*}" && cd .. && pwd )
VPN_HOME=$(realpath "$DEVKIT_HOME/../")
PROJECT_HOME=$(realpath "$VPN_HOME/../")

PATH_DEVKIT_CONF=$(realpath "$DEVKIT_HOME/conf")

NAME_DEVKIT="devkit"
NAME_DOCKER_SERVICE_VPND="vpnd"
NAME_DOCKER_CONTAINER_VPND="${NAME_DEVKIT}_${NAME_DOCKER_SERVICE_VPND}"

NAME_DOCKER_IMAGE_SYSD="evo/devkit:sysd"
NAME_DOCKER_IMAGE_SSHD="evo/devkit:sshd"
NAME_DOCKER_IMAGE_VPND="evo/devkit:vpnd"

FILE_AUTHORIZED_KEYS=$(realpath "${DEVKIT_HOME}/conf/authorized_keys")
FILE_DOCKER_COMPOSE=$(realpath "${DEVKIT_HOME}/docker-compose.yml")