#!/bin/bash

up_or_down=$1

amount=2.5

[ "$up_or_down" = up ] && plus_or_minus=+ || plus_or_minus=-

pactl set-sink-volume @DEFAULT_SINK@ "$plus_or_minus$amount"dB

notify-send -r 12937 -i pavucontrol -t 1000 volume.sh "Volume set logarithmically: $(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1) %"

# qdbus org.kde.plasmashell /org/kde/osdService volumeChanged "$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1)" 400 # Conflicts with the default OSD in Plasma 6
