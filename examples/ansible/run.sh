#!/usr/bin/env bash

DEVKIT_HOME=../../devkit

set -e

docker-compose down

${DEVKIT_HOME}/build.sh

#if [[ ! "$(docker network ls | grep outside)" ]]; then
#  docker network create outside
#fi

docker-compose up -d

ansible-playbook ansible-playbook.yml --extra-vars only=devkit

docker-compose down