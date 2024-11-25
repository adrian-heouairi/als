#!/bin/bash

[ "$USER" ] || exit 1

printf '%s\n' "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/als-sudo-without-password > /dev/null || exit 1

sudo mkdir -p /etc/polkit-1/rules.d || exit 1

echo "polkit.addRule(function(action, subject) {
    if (subject.isInGroup(\"$USER\")) {
        return polkit.Result.YES;
    }
});" | sudo tee /etc/polkit-1/rules.d/00-early-checks.rules > /dev/null
