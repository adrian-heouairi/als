#!/bin/bash

case "$1" in
hms) date +%H-%M-%S;;
ymd) date +%Y-%m-%d;;
ymdhms) date +%Y-%m-%d_%H-%M-%S;;
*) exit 1;;
esac
