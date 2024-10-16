#!/bin/bash

src=${1%/}/
dest=${2%/}/
shift 2

[ -d "$src" ] || exit 1
mkdir -p -- "$dest" || exit 1

rsync -a --delete --progress "$@" -- "$src" "$dest"
