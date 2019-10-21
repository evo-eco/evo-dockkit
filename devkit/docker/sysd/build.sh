#!/usr/bin/env bash

# make it so you can run from any directory: https://stackoverflow.com/a/16349776/726368
cd "${0%/*}"

docker build . -t "evo/devkit:sysd"