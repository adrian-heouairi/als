#!/bin/bash

# Confirmed working on KDE Neon 6.0
# Do not run this as root
# Assumes LUKS is not open

luks_path=$1 # Usually UUID=xxx
name=$2 # Will be used for name of file containing LUKS password, /dev/mapper name, mountpoint dir in ~/D/mnt # Only alphanumeric characters are supported
luks_password=$3
[ "$4" ] && unlocked_device_path=$4 || unlocked_device_path=/dev/mapper/$name

password_file=/luks-password-$name.txt

printf %s "$luks_password" | sudo tee -- "$password_file"
sudo chmod -- 600 "$password_file"

printf '\n%s\n' "$name $luks_path $password_file luks,keyscript=/bin/cat,nofail" | sudo tee -a /etc/crypttab

mountpoint=~/D/mnt/$name

mkdir -p -- "$mountpoint" || exit 1
printf '\n%s\n' "$unlocked_device_path $mountpoint auto nofail 0 2" | sudo tee -a /etc/fstab

sudo systemctl daemon-reload

sudo systemctl start systemd-cryptsetup@"$name".service
sleep 5
sudo mount -a
sleep 1

mountpoint -- "$mountpoint" && echo Everything succeeded || echo "$0: Something failed"
