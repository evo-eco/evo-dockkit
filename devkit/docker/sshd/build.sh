#!/usr/bin/env bash

# https://stackoverflow.com/a/16349776/726368
cd "${0%/*}"

docker build . -t "evo/devkit:sshd"