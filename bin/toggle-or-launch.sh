#!/bin/bash

win_title_substring=$1
shift # Rest of the arguments is command + args to launch if no window found

if [[ "$(xdotool getactivewindow getwindowname)" =~ "$win_title_substring" ]]; then
    xdotool getactivewindow windowminimize
else
    if ! wmctrl -a "$win_title_substring"; then
        "$@" & disown
    fi
fi












# Below an unfinished refinement

# win_title_substring=$1
# win_class=$2
# shift 2 # Rest of the arguments is command + args to launch if no window found

# current_win_title=$(xdotool getactivewindow getwindowname)
# current_win_class=$(get-current-window-class.sh)

# if [[ "" =~ "$win_title_substring" ]]; then
#     xdotool getactivewindow windowminimize
# else
#     if ! wmctrl -a "$win_title_substring"; then
#         "$@" & disown
#     fi
# fi
