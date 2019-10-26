#!/usr/bin/env bash

set -e

pushd "${BASH_SOURCE[0]%/*}" > /dev/null

SUFFIX=$1

if [[ -z "$SUFFIX" ]]; then
    # https://stackoverflow.com/questions/14352290/listing-only-directories-using-ls-in-bash-an-examination
    ls -1p | grep '/$' | sed 's/\/$//'
else
    ls -1p | grep "[0-9][0-9]\-$SUFFIX/$" | sed 's/\/$//'
fi

popd > /dev/null
