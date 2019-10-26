#!/usr/bin/env bash

set -e

source $(realpath "$( cd "${BASH_SOURCE[0]%/*}" && pwd )/../lib/shared.sh")

import util/exception

## enable basic logging for this file by declaring a namespace
namespace devkit-box

Log ""
Log " === box ==="
Log ""

run_docker_build_script "box" ${DEVKIT_REF_BOX}

Log ""
Log "done!"
Log ""