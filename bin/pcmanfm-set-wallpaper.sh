#!/bin/bash

image=$1

cp -f -- "$image" ~/.config/als-pcmanfm-wallpaper || exit 1

HOME=~
pcmanfm-qt --set-wallpaper="$HOME"/.config/als-pcmanfm-wallpaper

pcmanfm-qt --desktop-off
pcmanfm-qt --desktop
#pcmanfm-restart.sh
