#!/bin/bash

address=$1 # //192.168.1.35/myshare
password=$2 # Username is assumed to be 'abc'
mountpoint_basename=$3 # In /mnt/, also used for credentials file filename

password_file=/smb-credentials-$mountpoint_basename.txt

printf '%s\n%s\n' username=abc "password=$password" | sudo tee -- "$password_file"
sudo chmod -- 600 "$password_file"

mountpoint=/mnt/$mountpoint_basename

sudo mkdir -p -- "$mountpoint" || exit 1

printf '\n%s\n' "$address $mountpoint cifs nofail,credentials=$password_file,iocharset=utf8,uid=1000,gid=1000 0 0" | sudo tee -a /etc/fstab

sudo systemctl daemon-reload

sudo mount -a
sleep 3

mountpoint -- "$mountpoint" && echo Everything succeeded || echo "$0: Something failed"
