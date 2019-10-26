#!/usr/bin/env bash

set -e

source $(realpath "$( cd "${BASH_SOURCE[0]%/*}" && pwd )/../lib/shared.sh")

import util/exception

## enable basic logging for this file by declaring a namespace
namespace devkit-bin

Log ""
Log " === bin ==="
Log ""

run_docker_build_script "bin" ${DEVKIT_REF_BIN}

Log ""
Log "done!"
Log ""