#!/bin/bash

set -o pipefail; if id=$(wmctrl -lx | grep -Fm1 ' 0 pcmanfm-qt.pcmanfm-qt ' | awk '{ print $1 }'); then wmctrl -ia "$id"; else pcmanfm-restart.sh; fi
