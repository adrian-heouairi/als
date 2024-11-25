#!/bin/bash

clipboard=$(xsel -b)
[ "$clipboard" ] || exit 1

fullpath=$(conv-file-url-to-fullpath.sh "$clipboard") || exit 1
[ "$fullpath" ] || exit 1

[ -e "$fullpath" ] || {
    dirname=$(dirname -- "$fullpath")
    [[ $dirname =~ ^/.+ ]] || exit 1
    [ -d "$dirname" ] || exit 1
    fullpath=$dirname/dolphin-absent-file
}

dolphin --select -- "$fullpath"





# Comment this (1) or not (2) for the following case: when clibpoard is /tmp/, what we should do: (1): select tmp in / or (2): open a new Dolphin tab in /tmp. In every case a clibpoard of /tmp will select tmp in /.
