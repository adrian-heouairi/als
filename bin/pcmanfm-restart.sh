#!/bin/bash

id=$(wmctrl -lx | grep -Fm1 ' 0 pcmanfm-qt.pcmanfm-qt ' | awk '{ print $1 }')
wmctrl -ic "$id"
sleep .25
pcmanfm-qt -q
pcmanfm-qt --desktop & disown
sleep .25
pcmanfm-qt & disown
