#!/bin/bash

current_desktop=$(wmctrl -d | awk '$2 == "*" {print $1}')

l=$(wmctrl -lx | awk "\$2 == "$current_desktop" {print \$0}" | grep -Ev 'konsole.konsole +[^ ]+ +— Konsole' | grep -E "$1" | fzf) && wmctrl -ia "$(cut -d" " -f1 <<< "$l")"
