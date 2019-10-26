#!/usr/bin/env bash

set -e

source $(realpath "$( cd "${BASH_SOURCE[0]%/*}" && pwd )/../lib/shared.sh")

## enable basic logging for this file by declaring a namespace
namespace devkit-sshd

Log ""
Log " === sshd ==="
Log ""

run_docker_build_script "sshd" ${DEVKIT_REF_SSHD}

Log ""
Log "done!"
Log ""
