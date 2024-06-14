#!/bin/bash

ln -s -f /usr/share/doc/mpv/examples/lua/autoload.lua ~/.config/mpv/scripts/autoload.lua

# cp -f -- "$(linux-setup-get-resources-path.sh)/dot-desktop-files/mpv-open-at-timestamp.desktop" ~/.local/share/applications/

# set-default-application.sh video/mp4 mpv.desktop
# set-default-application.sh video/x-matroska mpv.desktop

# w=$(which mpv-open.sh) && ln -s -- "$w" ~/Desktop
# w=$(which mpv-close.sh) && ln -s -- "$w" ~/Desktop || true
