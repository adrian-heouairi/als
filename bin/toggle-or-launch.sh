#!/bin/bash

# $1 and $2 are case-sensitive extended regexes that must match a substring of title and class of the window for which to toggle focus. If such a window is not found, $3 and so on are command and args to run.

# TODO: Both regexes may be anchored with ^ and $.
#win_title_regex=${1/#'^'/' '}
#win_class_regex=${2/#'^'/' '} win_class_regex=${win_class_regex/'$'%/' '}

win_title_regex=$1
win_class_regex=$2
shift 2

current_win_id=$(xdotool getactivewindow)
#[ "$current_win_id" ] && current_win_id=$(printf 0x%08x "$current_win_id")

win_id_if_exists=$(wmctrl -lx | grep -E "$win_title_regex" | grep -Em1 "$win_class_regex" | cut -d' ' -f1)
[ "$win_id_if_exists" ] && win_id_if_exists=$(printf %d "$win_id_if_exists")

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
