#!/bin/bash

sed -Ez 's|.*\[Containments]\[1]\[Wallpaper]\[org\.kde\.image]\[General]\nImage=(file://)?([^\n]+).*|\2|' ~/.config/plasma-org.kde.plasma.desktop-appletsrc | sed 's|^|file://|' | xsel -b; notify-send -i edit-copy 'Copied wallpaper URL to clipboard' "$(xsel -o -b)"
