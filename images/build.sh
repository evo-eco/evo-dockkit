#!/usr/bin/env bash

##
#
# usage:
#   all: ./build.sh
#   one: ./build.sh vpnd
#
##

set -e

## make it so you can run from any directory: https://stackoverflow.com/a/16349776/726368
pushd "${BASH_SOURCE[0]%/*}" > /dev/null

source ../lib/shared.sh

import util/

## enable basic logging for this file by declaring a namespace
namespace devkit

function make() {
    Log ""
    Log "running: ./$1/build.sh"
    Log ""

    ./$1/build.sh
#    echo d
}

announce_env

FILTER=$1

./list-images.sh "$FILTER" |  while read line
do
    make ${line}
done

popd > /dev/null

# using colors:
#echo "$(UI.Color.Blue)I'm blue...$(UI.Color.Default)"

# now we can write with the DEBUG output set
#Log "0 Play me some Jazz, will ya? $(UI.Powerline.Saxophone)"
#subject=debug Log "1 Play me some Jazz, will ya? $(UI.Powerline.Saxophone)"