#!/bin/bash

# autostart.sh scripts in packages can run idempotent one-shot commands. They can also launch daemons. These scripts must kill (with SIGKILL if needed) the daemons before launching them.
# Scripts in autostart.d can do whatever they want.

source -- "$(dirname -- "$(dirname -- "$(realpath -- "$0")")")/source/als-bin.sh" || exit 1

for i in "$ALS_INSTALLED_FULLPATH"/packages/*/autostart.sh "$ALS_CUSTOM_FULLPATH"/autostart.d/*; do # nullglob is set
    "$i" & disown
done
