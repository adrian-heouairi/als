#!/bin/bash

ids=$(wmctrl -lx | awk "\$3 == \"$1\" { print $\1 }")

for i in $ids; do
    wmctrl -Fir "$i" -b add,maximized_horz,maximized_vert
done
