#!/usr/bin/env bash

set -e

# make it so you can run from any directory: https://stackoverflow.com/a/16349776/726368
#cd "${0%/*}"

SHARED_HOME=$( cd "${BASH_SOURCE[0]%/*}" && pwd )
PROJECT_HOME=$(realpath "$SHARED_HOME/../")

## BOOTSTRAP ##
source "${PROJECT_HOME}/lib/bash-oo-framework/lib/oo-bootstrap.sh"

import util/exception
import util/

## ADD OUTPUT OF "namespace" TO DELEGATE STDERR
Log::AddOutput default DEBUG

Log::AddOutput debug DEBUG
Log::AddOutput error ERROR

Log::AddOutput evo CUSTOM
#Log::AddOutput setup DEBUG

namespace evo

source "./functions.sh"

function echo_announce() {
    subject=evo Log "#####"
    subject=evo Log "#      ___ __   __ ___       ___   ___  ___"
    subject=evo Log "#     / _ \\ \  / // _ \     / _ \ / __|/ _ \ "
    subject=evo Log "#    |  __/ \ V /| (_) | - |  __/| (__| (_) |"
    subject=evo Log "#     \___|  \_/  \___/     \___| \___|\___/"
    subject=evo Log "#"
    subject=evo Log "# @author  msmyers"
    subject=evo Log "#"
    subject=evo Log "#####"
    echo ""
}