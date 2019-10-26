#!/usr/bin/env bash

TAG=$1

# https://stackoverflow.com/a/16349776/726368
cd "${0%/*}"

if [[ -z $(docker image ls -q -a -f reference="$TAG") ]]; then
    docker build . -t "$TAG"
fi