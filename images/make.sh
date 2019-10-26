#!/usr/bin/env bash

set -e

## make it so you can run from any directory: https://stackoverflow.com/a/16349776/726368
pushd "${0%/*}" > /dev/null


    source ../lib/shared.sh
    #source $(realpath "$( cd "${BASH_SOURCE[0]%/*}" && pwd )/../../lib/variables.sh")

    import util/

    ## enable basic logging for this file by declaring a namespace
    namespace devkit

    function make() {
        Log ""
        Log "running: ./docker-build-$1.sh"
        Log ""
        ./docker-build-$1.sh
        echo
    }

    announce_env

    make "sysd"
    make "sshd"
    make "vpnd"
    make "box"
    make "bin"

popd > /dev/null

# using colors:
#echo "$(UI.Color.Blue)I'm blue...$(UI.Color.Default)"

# now we can write with the DEBUG output set
#Log "0 Play me some Jazz, will ya? $(UI.Powerline.Saxophone)"
#subject=debug Log "1 Play me some Jazz, will ya? $(UI.Powerline.Saxophone)"