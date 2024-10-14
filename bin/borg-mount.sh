#!/bin/bash

notify-send "Launching borg-mount.sh on '$1'"

borg_repo_fullpath=$(realpath -- "$1")

[[ $borg_repo_fullpath =~ ^/.+ ]] || exit 1

basename=$(basename -- "$borg_repo_fullpath")

mount_fullpath=/tmp/borg_$(basename -- "$(dirname -- "$borg_repo_fullpath")")_$basename

mkdir -p "$mount_fullpath" || exit 1

qterminal -e borg mount "$borg_repo_fullpath" "$mount_fullpath"

mountpoint "$mount_fullpath" && pcmanfm-qt "$mount_fullpath"
