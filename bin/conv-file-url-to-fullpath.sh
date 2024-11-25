#!/bin/bash

# "Idempotent" if the input is already a full path without URL scheme
# Tries to be smart: checks if file exists with and without URL decoding
# Will transform a tilde at the beginning of the input to the full path of the home directory

input=$1

[ "$input" ] || exit 1

input=${input/#'~'/~}

input=${input/#'file://'}

[ -e "$input" ] || input=$(conv-url-decode.sh "$input")

input=$(sed 's|/$||' <<< "$input")

printf '%s\n' "$input"
