#!/bin/bash
#als-desktop %f

[ "$1" ] && dir=$1 || dir=.

konsole --new-tab --workdir "$(realpath -- "$dir")" & disown
wmctrl -Fxa konsole.konsole || true
