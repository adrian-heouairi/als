#!/bin/bash

source ~/.local/als/source/als-bin.sh || exit 1

exec "$SCRIPT_DIR_FULLPATH"/upgrade.sh
