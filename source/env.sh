#!/bin/bash

# The environment that we want everyone to have, including programs not part of als
# All environment variable definitions must be idempotent, meaning that they can be sourced multiple times without changing the result
# Note that globbing and IFS splitting are disabled for export and local shell builtins (but not echo)

[ "$HOME" ] || export HOME=~

export ALS_FULLPATH=$(dirname -- "$(dirname -- "$(realpath -- "$BASH_SOURCE")")")
export ALS_INSTALLED_FULLPATH=~/.local/als-installed
export ALS_CUSTOM_FULLPATH=~/.local/als-custom

# The shell version is made to be written to scripts e.g. echo "echo $ALS_FULLPATH_SHELL" >> script.sh (no quotes needed around $ALS_FULLPATH_SHELL). $HOME fullpath is also replaced by ~.
ALS_FULLPATH_SHELL=$(printf %q "$ALS_FULLPATH")
export ALS_FULLPATH_SHELL=${ALS_FULLPATH_SHELL/#"$HOME"/'~'}
export ALS_INSTALLED_FULLPATH_SHELL='~'/.local/als-installed
export ALS_CUSTOM_FULLPATH_SHELL='~'/.local/als-custom

[[ $PATH =~ (:|^)"$ALS_FULLPATH/bin"(:|$) ]] || export PATH=$ALS_CUSTOM_FULLPATH/bin:$ALS_INSTALLED_FULLPATH/bin-symlinks:$ALS_FULLPATH/bin:$PATH

dont_change_i() {
    local i
    for i in "$ALS_INSTALLED_FULLPATH"/packages/*/env.sh "$ALS_CUSTOM_FULLPATH"/env.d/*; do
        [[ $i =~ /\*(/|$) ]] && continue # TODO We don't want to change nullglob but nullglob status is given by 'shopt nullglob'
        source -- "$i"
    done

}
dont_change_i
unset -f dont_change_i
