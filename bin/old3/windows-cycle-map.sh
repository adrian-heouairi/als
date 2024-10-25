#!/bin/bash

case "$1" in
z) c='\[General\]';;
c) c='\[Music\]';;
v) c='\[Videos\]';;
x) c='\[Social\]';;
esac

exec windows-cycle.sh "$c"
