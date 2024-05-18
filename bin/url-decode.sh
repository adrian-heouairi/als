#!/bin/bash

source ~/.local/als/source/als-bin.sh || exit 1

input_to_array args "$@"

IFS=$'\n'

exec python3 -c 'import sys; from urllib.parse import unquote; print(unquote(sys.argv[1]))' "${args[*]}"
