#!/bin/bash
#als-desktop %f

borg_repo_fullpath=$(realpath -- "$1")

notify-send -i drive-harddisk borg-mount.sh "Launching borg-mount.sh on '$borg_repo_fullpath'"

[[ $borg_repo_fullpath =~ ^/.+ ]] || exit 1

basename=$(basename -- "$borg_repo_fullpath")

mount_fullpath=/tmp/borg_$(basename -- "$(dirname -- "$borg_repo_fullpath")")_$basename

mkdir -p "$mount_fullpath" || exit 1

konsole -e borg mount "$borg_repo_fullpath" "$mount_fullpath"

mountpoint "$mount_fullpath" && dolphin "$mount_fullpath"

echo "Unmount later with 'borg umount '$mount_fullpath'' or 'sudo umount '$mount_fullpath''"

notify-send -i drive-harddisk borg-mount.sh "Unmount later with 'borg umount '$mount_fullpath'' or 'sudo umount '$mount_fullpath''"
