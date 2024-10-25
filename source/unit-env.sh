#!/bin/sh

# The environment that we want everyone to have, including programs not part of als
# All environment variable definitions must be idempotent, meaning that they can be sourced multiple times without changing the result
# Note that globbing and IFS splitting are disabled for export and local shell builtins (but not echo) in bash but not sh?

[ "$HOME" ] || export HOME=~

export ALS_FULLPATH=~/.local/als
export ALS_INSTALLED_FULLPATH=~/.local/als-installed
export ALS_CUSTOM_FULLPATH=~/.local/als-custom

if [ -e /home/linuxbrew/.linuxbrew/bin/brew ]; then
    ulimit -Sn "$(ulimit -Hn)"; eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

printf '%s\n' "$PATH" | sed 's/:/\n/g' | grep -qFx "$HOME/.local/bin" || export "PATH=$HOME/.local/bin:$PATH"
printf '%s\n' "$PATH" | sed 's/:/\n/g' | grep -qFx "$HOME/bin" || export "PATH=$HOME/bin:$PATH"

printf '%s\n' "$PATH" | sed 's/:/\n/g' | grep -qFx "$ALS_FULLPATH/bin" || export "PATH=$ALS_CUSTOM_FULLPATH/bin:$ALS_INSTALLED_FULLPATH/bin-symlinks:$ALS_FULLPATH/bin:$PATH"

for ALS_I in "$ALS_INSTALLED_FULLPATH"/packages/*/env.sh "$ALS_CUSTOM_FULLPATH"/env.d/*; do
    [ -f "$ALS_I" ] || continue
    . "$ALS_I" || exit 1
done
unset ALS_I
