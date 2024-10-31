#!/bin/bash

clipboard=$(xsel -b)
[ "$clipboard" ] || exit 1

clipboard=${clipboard/#'~'/~}

clipboard=${clipboard/#'file://'}
[ -e "$clipboard" ] || clipboard=$(conv-url-decode.sh "$clipboard")

dolphin --select "$clipboard"
