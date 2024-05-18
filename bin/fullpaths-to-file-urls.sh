#!/bin/bash

source ~/.local/als/source/als-bin.sh || exit 1

input_to_array args "$@"

IFS=$'\n'
sed 's;^file://;;' <<< "${args[*]}"
