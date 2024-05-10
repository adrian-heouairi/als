#!/bin/bash

source "$(dirname "$(realpath -- "$BASH_SOURCE")")/als-bin.sh" || exit 1

export ALS_PACKAGE_NAME=$SCRIPT_DIR_NAME
