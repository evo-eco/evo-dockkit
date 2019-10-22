#!/usr/bin/env bash

set -e

# https://stackoverflow.com/a/16349776/726368
cd "${0%/*}"

#Log " >>> SSHd: setup"
cat ~/.ssh/id_rsa.pub > authorized_keys;

docker build . -t "evo/devkit:bin"

rm authorized_keys;