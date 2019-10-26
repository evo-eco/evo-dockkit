#!/usr/bin/env bash

TAG=$1

set -e

# https://stackoverflow.com/a/16349776/726368
pushd "${0%/*}" > /dev/null

source ../vars.sh

TAG=${1:-${DEVKIT_REF_BOX}}

#Log " >>> SSHd: setup"
cat ~/.ssh/id_rsa.pub > authorized_keys;

exec_docker_build "$TAG"

rm authorized_keys;

popd > /dev/null
