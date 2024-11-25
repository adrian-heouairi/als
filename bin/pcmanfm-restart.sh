#!/bin/bash

#id=$(wmctrl -lx | grep -Fm1 ' 0 pcmanfm-qt.pcmanfm-qt ' | awk '{ print $1 }')
#wmctrl -ic "$id"
#sleep .25

pidof pcmanfm-qt && {
    pcmanfm-qt -q & disown
    sleep 1
}

pidof pcmanfm-qt && {
    killall -9 pcmanfm-qt
    sleep 1
}

pcmanfm-qt --daemon-mode & disown
sleep 1
pcmanfm-qt --desktop & disown

#sleep .25
#pcmanfm-qt & disown
