#!/bin/bash

# $1 and $2 are case-sensitive extended regexes that will both be used to filter a wmctrl -lx line. Typically, $1 is for title of the window and $2 for class, but it could be anything. Pass -v option to pass -v to the first grep. We take the first match. If such a window is not found, $3 and so on are command and args to run.

grep_v=
[ "$1" = -v ] && {
    grep_v=-v
    shift
}

win_title_regex=$1
win_class_regex=$2
shift 2

current_win_id=$(xdotool getactivewindow) # ID is in base 10, no padding
#[ "$current_win_id" ] && current_win_id=$(printf 0x%08x "$current_win_id")

win_id_if_exists=$(wmctrl -lx | grep $grep_v -E "$win_title_regex" | grep -Em1 "$win_class_regex" | cut -d' ' -f1)
[ "$win_id_if_exists" ] && win_id_if_exists=$(printf %d "$win_id_if_exists") # Convert padded 0x0001ABCD to base 10 without padding

if [ "$win_id_if_exists" ]; then
    if [ "$win_id_if_exists" = "$current_win_id" ]; then
        xdotool getactivewindow windowminimize
    else
        wmctrl -ia "$win_id_if_exists" # TODO: What should we do in case the window is on another desktop than the current one?
    fi
else
    if [ "$*" ]; then
        "$@" & disown
    fi
fi









# Below is the old version that only matches a substring of the title of the window

# win_title_regex=$1
# shift # Rest of the arguments is command + args to launch if no window found

# if [[ "$(xdotool getactivewindow getwindowname)" =~ "$win_title_regex" ]]; then
#     xdotool getactivewindow windowminimize
# else
#     if ! wmctrl -a "$win_title_regex"; then
#         "$@" & disown
#     fi
# fi
