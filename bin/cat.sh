#!/bin/bash

source ~/.local/als/source/als-bin.sh || exit 1

input_to_array args "$@"

for i in "${args[@]}"; do
    printf '######################################## '
    realpath -- "$i"
    echo
    cat -- "$i"
    echo
done
