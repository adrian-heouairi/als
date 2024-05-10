#!/bin/bash

source "$(dirname "$(realpath -- "$BASH_SOURCE")")/unit-als-bash-functions.sh" || exit 1
source "$(dirname "$(realpath -- "$BASH_SOURCE")")/unit-als-env.sh" || exit 1
source "$(dirname "$(realpath -- "$BASH_SOURCE")")/unit-bash-defaults.sh" || exit 1
source "$(dirname "$(realpath -- "$BASH_SOURCE")")/unit-bash-functions.sh" || exit 1
ALS_ARG_ALS_FULLPATH=$(dirname "$(dirname "$(realpath -- "$BASH_SOURCE")")") source "$(dirname "$(realpath -- "$BASH_SOURCE")")/unit-env.sh" || exit 1
