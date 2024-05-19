#!/bin/bash

# $1 examples: -5dB +5dB -5%

pactl set-sink-volume @DEFAULT_SINK@ "$1"
qdbus org.kde.plasmashell /org/kde/osdService volumeChanged "$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1)" 400
