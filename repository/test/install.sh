#!/bin/bash

source "$(dirname "$(dirname "$(dirname "$(realpath -- "$BASH_SOURCE")")")")"/source/als-packages.sh || exit 1

echo test package installed "$ALS_FULLPATH"
