#!/usr/bin/env bash

set -e

#        # need IntelliJ to know about these vars
#        {
#            # make it so you can run from any directory: https://stackoverflow.com/a/16349776/726368
#            pushd "${0%/*}" > /dev/null
#            source ../vars.sh
#            popd > /dev/null
#        }

## make it so you can run from any directory: https://stackoverflow.com/a/16349776/726368
pushd "${BASH_SOURCE[0]%/*}" > /dev/null

source ../lib/shared.sh

# colors + exception traps
import util

# required for logging (bleh, per file)
namespace evo

{
    function exec_docker_build() {
        local TAG=$1

        if [[ -z $(docker image ls -q -a -f reference="$TAG") ]]; then
            docker build . -t "$TAG"
        fi
    }

    function echo_fixed_line() {
        local PROC_NAME=$1
        local STATUS=$2

        subject=evo Log $(printf "%-42s%s\n" "$PROC_NAME~" "~[ $STATUS ]" | tr ' ~' '- ')
    }

    function echo_status_line() {
        echo_fixed_line $1 $([[ -z $2 ]] && echo "$(UI.Color.Green)CLEAN$(UI.Color.Default)" || echo "$(UI.Color.Red)CLEANING$(UI.Color.Default)")
    }

}

popd > /dev/null