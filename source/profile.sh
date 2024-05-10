#!/bin/sh

# Source this script with ALS_ARG_ALS_FULLPATH set to the fullpath of als e.g. ALS_ARG_ALS_FULLPATH=~/als . ~/als/source/profile.sh

[ "$ALS_ARG_ALS_FULLPATH" ] || exit 1

source "$ALS_ARG_ALS_FULLPATH/source/unit-env.sh" || exit 1
