#!/usr/bin/env bash

TAG=$1

# https://stackoverflow.com/a/16349776/726368
cd "${0%/*}"

docker build . -t "$TAG"