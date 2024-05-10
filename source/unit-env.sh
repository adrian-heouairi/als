#!/bin/sh

# Source this script with ALS_ARG_ALS_FULLPATH set to the fullpath of als e.g. ALS_ARG_ALS_FULLPATH=~/als . ~/als/source/unit-env.sh

# The environment that we want everyone to have, including programs not part of als
# All environment variable definitions must be idempotent, meaning that they can be sourced multiple times without changing the result
# Note that globbing and IFS splitting are disabled for export and local shell builtins (but not echo)

[ "$ALS_ARG_ALS_FULLPATH" ] || exit 1

[ "$HOME" ] || export HOME=~

export ALS_FULLPATH=$ALS_ARG_ALS_FULLPATH
export ALS_INSTALLED_FULLPATH=~/.local/als-installed
export ALS_CUSTOM_FULLPATH=~/.local/als-custom

printf '%s\n' "$PATH" | grep -q -F "$ALS_FULLPATH/bin" || export PATH=$ALS_CUSTOM_FULLPATH/bin:$ALS_INSTALLED_FULLPATH/bin-symlinks:$ALS_FULLPATH/bin:$PATH

for ALS_I in "$ALS_INSTALLED_FULLPATH"/packages/*/env.sh "$ALS_CUSTOM_FULLPATH"/env.d/*; do
    [ -f "$ALS_I" ] || continue
    . "$ALS_I" || exit 1
done
unset ALS_I
