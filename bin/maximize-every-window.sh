#!/bin/bash

wmctrl -l | while read -r line; do
    window_id=$(echo "$line" | awk '{print $1}')
    wmctrl -i -r "$window_id" -b add,maximized_vert,maximized_horz
done
