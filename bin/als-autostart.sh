#!/bin/bash

# autostart.sh scripts in packages can run idempotent one-shot commands. They can also launch daemons. If daemons are launched, the package should also provide a stop-daemons.sh script that must stop the daemons and always return 0.
# Scripts in autostart.d can do whatever they want.

source "$(dirname "$(dirname "$(realpath -- "$BASH_SOURCE")")")"/source/als-bin.sh || exit 1

for i in "$ALS_INSTALLED_FULLPATH"/packages/*/autostart.sh "$ALS_CUSTOM_FULLPATH"/autostart.d/*; do # nullglob is set
    "$i" & disown
done
