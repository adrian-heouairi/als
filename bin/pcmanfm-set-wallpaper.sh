#!/bin/bash
#als-desktop %f

image=$1

cp -f -- "$image" ~/.config/als-pcmanfm-wallpaper || exit 1

HOME=~
pcmanfm-qt --set-wallpaper="$HOME"/.config/als-pcmanfm-wallpaper &> /dev/null

pcmanfm-qt --desktop-off &> /dev/null
pcmanfm-qt --desktop &> /dev/null & disown
#pcmanfm-restart.sh
