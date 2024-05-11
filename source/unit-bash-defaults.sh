#!/bin/bash

# Bash defaults that any script can source

# All variable definitions in this script are available to scripts that source it, even without export
# Arguments passed to the sourcing script are available here, even without explicitly passing them when sourcing

set -u -e -o pipefail
shopt -s extglob
shopt -s nullglob

trap exit SIGINT

[ "${1+"$1"}" = --cat ] && {
    cat -- "$0"
    exit 1 # Makes the sourcing script exit
}

SCRIPT_FULLPATH=$(realpath -- "$0") # $0 is the script that sources, $BASH_SOURCE is the sourced script (this script)
SCRIPT_DIR_FULLPATH=$(dirname -- "$SCRIPT_FULLPATH")
SCRIPT_DIR_NAME=$(basename -- "$SCRIPT_DIR_FULLPATH")
SCRIPT_NAME=$(basename -- "$SCRIPT_FULLPATH")

error_handler() {
    local exit_code=$?
    local error_line=$1
    local error_command=$(sed "${error_line}q;d" "$0" | sed -E 's/^[[:blank:]]+//')
    printf '%s\n' "$SCRIPT_FULLPATH: Error on line $error_line: '$error_command', exit code: $exit_code" >&2
}
trap 'error_handler "$LINENO"' ERR
