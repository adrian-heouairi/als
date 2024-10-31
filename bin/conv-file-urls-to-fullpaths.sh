#!/bin/bash

source ~/.local/als/source/als-bin.sh || exit 1

input_to_array args "$@"

IFS=$'\n'

no_protocol=$(sed 's;^file://;;' <<< "${args[*]}")
fullpaths=$(conv-url-decode.sh "$no_protocol")
printf '%s\n' "$fullpaths"

if [ "$(grep -c . <<< "$fullpaths")" = 1 ]; then
    [ -e "$fullpaths" ]
else
    exit 0
fi
