#!/bin/bash

copy_array() {
    local from_var_name=$1
    local to_var_name=$2
    unset "$to_var_name"
    declare -g -a "$to_var_name"
    local i c=0 from_var_name_at=$from_var_name"[@]"
    for i in "${!from_var_name_at}"; do
        printf -v "${to_var_name}[$((c++))]" %s "$i"
    done
}

is_assoc_array() {
    local var_name=$1
    [[ $(declare -p "$var_name" 2> /dev/null || true) =~ ^"declare -A" ]]
}

print_err() {
    printf '\e[1;31m%s\e[m\n' "$*" >&2
}

print_debug() {
    printf '\e[1;34m%s\e[m\n' "$*" >&2
}

print_err_exit() {
    print_err "$1"
    exit "${2:-1}" # $2 or 1 if $2 is not set
}
