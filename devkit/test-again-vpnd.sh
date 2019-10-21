#!/usr/bin/env bash

FILE_AUTHORIZED_KEYS=./authorized_keys

# make it so you can run from any directory: https://stackoverflow.com/a/16349776/726368
cd "${0%/*}"

source "./lib/variables.sh"

# colors + exception traps
import util/

# required for logging (bleh, per file)
namespace evo


Log " >>>> RUN: ansible-playbook install-vpn.yml --extra-vars \"only=DEVKIT\";"
pushd ../; ansible-playbook install-vpn.yml --extra-vars "only=DEVKIT"; popd;

