#!/usr/bin/env bash

set -e

# install
#       mkdir -p ~/projects/devkit-deploy
#       git clone evo-* to

ME="${BASH_SOURCE[0]%}"
PATH_ME=$(realpath $( cd "${BASH_SOURCE[0]%/*}" && pwd ))

PATH_REPO=
PATH_TOOLING=
PATH_INSTALLED=

if [[ -L "$ME" ]]; then
    PATH_TOOLING=$(dirname $(readlink "$ME"))
    PATH_REPO=$(realpath $( cd "${PATH_TOOLING}" && cd .. && pwd ))
    PATH_INSTALLED=${PATH_ME}
else
    PATH_INSTALLED=
    PATH_TOOLING=${PATH_ME}
    PATH_REPO=$(realpath "$PATH_TOOLING/..")
fi

pushd $PATH_TOOLING

source ./tools.sh

pushd "$PATH_TOOLING/bin"

if [[ $1 == "build" ]]; then
    build_devkit_image
fi

popd

popd