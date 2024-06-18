#!/bin/bash

# autostart.sh scripts in packages can run idempotent one-shot commands. They can also launch daemons. If daemons are launched, the package should also provide a stop-daemons.sh script that must stop the daemons and always return 0.
# Scripts in autostart.d can do whatever they want.

source ~/.local/als/source/als-bin.sh || exit 1

for i in "$ALS_INSTALLED_FULLPATH"/packages/*/autostart.sh "$ALS_CUSTOM_FULLPATH"/autostart.d/*; do # nullglob is set
    #nohup "$i" &> /dev/null & disown
    "$i" &
done

sleep infinity # Doing this makes Plasma 6 hang at login if in ~/.config/autostart, omg KDE is so bad
