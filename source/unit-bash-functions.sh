#!/bin/bash

copy_array() {
    local from_var_name=$1
    local to_var_name=$2

    unset "$to_var_name"
    declare -g -a "$to_var_name"

    local i c=0
    for i in "${!from_var_name[@]}"; do
        printf -v "${to_var_name}[$c]" %s "$i"
        ((c++))
    done
}
