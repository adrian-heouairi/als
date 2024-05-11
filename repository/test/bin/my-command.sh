#!/bin/bash

source "$(dirname "$(dirname "$(dirname "$(dirname "$(realpath -- "$BASH_SOURCE")")")")")"/source/als-bin.sh || exit 1

echo test package command "$ALS_FULLPATH"
