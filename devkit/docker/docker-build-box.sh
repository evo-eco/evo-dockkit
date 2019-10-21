#!/usr/bin/env bash

set -e

source $(realpath "$( cd "${BASH_SOURCE[0]%/*}" && pwd )/../lib/variables.sh")

import util/exception

## enable basic logging for this file by declaring a namespace
namespace devkit-vpnd

Log ""
Log " === vpnd ==="
Log ""

run_docker_build_script "vpnd"

Log ""
Log "done!"
Log ""