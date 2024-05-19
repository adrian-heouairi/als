#!/bin/bash

case "$1" in
hms) date +%H:%M:%S;;
ymd) date +%Y-%m-%d;;
*) date '+%Y-%m-%d %H:%M:%S';;
esac
