#!/bin/bash

# Works with symbolic links

source "$(dirname "$(dirname "$(realpath -- "$BASH_SOURCE")")")"/source/als-bin.sh || exit 1

file=$1
line=$2

if [ -e "$file" ] && ! [ -f "$file" ]; then
    rm -rf -- "$file$ALS_OLD_EXT"
    mv -f -- "$file" "$file$ALS_OLD_EXT"
fi

grep -Fx -- "$line" "$file" &> /dev/null || printf '\n%s\n' "$line" >> "$file"
