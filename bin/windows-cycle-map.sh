#!/bin/bash

case "$1" in
q) c='\[General\] - Chrome$';;
c) c='\[Music\] - Chrome$';;
v) c='\[Videos\] - Chrome$';;
x) c='\[Social\] - Chrome$';;
esac

exec windows-cycle.sh "$c"
