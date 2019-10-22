#!/usr/bin/env bash

DEVKIT_HOME=../../devkit

set -e

echo $(realpath ${DEVKIT_HOME}/build.sh)

${DEVKIT_HOME}/build.sh

docker-compose down

docker-compose up -d

ansible-playbook ansible-playbook.yml