#!/usr/bin/env bash

DEVKIT_HOME=../../devkit

set -e

docker-compose down

${DEVKIT_HOME}/build.sh

docker-compose up -d

docker exec devkit_example_script /home/pi/hello-world.sh

docker stop devkit_example_script