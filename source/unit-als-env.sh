#!/bin/bash

[ "$HOME" ] || export HOME=~

export ALS_OLD_EXT=.old

# The shell version is made to be written to scripts e.g. echo "echo $ALS_FULLPATH_SHELL" >> script.sh (no quotes needed around $ALS_FULLPATH_SHELL). $HOME fullpath is also replaced by ~.
ALS_FULLPATH_SHELL=$(printf %q "$(dirname "$(dirname "$(realpath -- "$BASH_SOURCE")")")")
export ALS_FULLPATH_SHELL=${ALS_FULLPATH_SHELL/#"$HOME"/'~'}
export ALS_INSTALLED_FULLPATH_SHELL='~'/.local/als-installed
export ALS_CUSTOM_FULLPATH_SHELL='~'/.local/als-custom
