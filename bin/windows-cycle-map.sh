#!/bin/bash

case "$1" in
q) c='\[General\]';;
c) c='\[Music\]';;
v) c='\[Videos\]';;
x) c='\[Social\]';;
esac

exec windows-cycle.sh "$c"
