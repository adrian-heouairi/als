#!/bin/bash

[ "$USER" ] || exit 1

printf '%s\n' "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/als-sudo-without-password > /dev/null
