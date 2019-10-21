#!/usr/bin/env bash

set -e

source $(realpath "$( cd "${BASH_SOURCE[0]%/*}" && pwd )/../lib/variables.sh")

## enable basic logging for this file by declaring a namespace
namespace devkit-sshd

Log ""
Log " === sshd ==="
Log ""

run_docker_build_script "sshd"

Log ""
Log "done!"
Log ""
