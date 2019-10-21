#!/usr/bin/env bash

FILE_AUTHORIZED_KEYS=./authorized_keys

# make it so you can run from any directory: https://stackoverflow.com/a/16349776/726368
cd "${0%/*}"

source "./lib/variables.sh"

# colors + exception traps
import util/

# required for logging (bleh, per file)
namespace evo

### step 1, make sure it exists

Log "exec ./reset-shell-vpnd.sh"
$(realpath "$DEVKIT_HOME/reset-shell-vpnd.sh")

Log "exec ./build-shell-vpnd.sh"
$(realpath "$DEVKIT_HOME/build-shell-vpnd.sh")

Log "exec ./test-again-vpnd.sh"
$(realpath "$DEVKIT_HOME/test-again-vpnd.sh")
