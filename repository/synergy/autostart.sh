#!/bin/bash

source ~/.local/als/source/als-bin.sh || exit 1

candidates=(~/.local/als-custom*/packages-conf/synergy/"$HOSTNAME".sh)

[ -f "$candidates" ] && exec "$candidates"
