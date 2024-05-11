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
