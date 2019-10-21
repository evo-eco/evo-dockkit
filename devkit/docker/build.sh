#!/usr/bin/env bash

set -e

## make it so you can run from any directory: https://stackoverflow.com/a/16349776/726368
cd "${0%/*}"

source "../lib/variables.sh"

import util/

## enable basic logging for this file by declaring a namespace
namespace devkit

announce

Log ""
Log "running: ./docker-build-sysd.sh"
Log ""
./docker-build-sysd.sh

Log ""
Log "running: ./docker-build-sshd.sh"
Log ""
./docker-build-sshd.sh

Log ""
Log "./docker-build-vpnd.sh"
Log ""
docker-build-box.sh

# using colors:
#echo "$(UI.Color.Blue)I'm blue...$(UI.Color.Default)"

# now we can write with the DEBUG output set
#Log "0 Play me some Jazz, will ya? $(UI.Powerline.Saxophone)"
#subject=debug Log "1 Play me some Jazz, will ya? $(UI.Powerline.Saxophone)"
