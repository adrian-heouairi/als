#!/bin/bash

copy_array() {
    local from_var_name=$1
    local to_var_name=$2
print-debug point x1
    unset "$to_var_name"
    declare -g -a "$to_var_name"
print-debug point x2
    local i c=0 from_var_name_at=$from_var_name"[@]"
    for i in "${!from_var_name_at}"; do
        print-debug point x3 "i = $i, from_var_name = $from_var_name, to_var_name = $to_var_name, c = $c"
        printf -v "${to_var_name}[$((c++))]" %s "$i"
        print-debug point x4 "c = $c"
    done
}

is_assoc_array() {
    local var_name=$1
    [[ $(declare -p "$var_name" 2> /dev/null || true) =~ ^"declare -A" ]]
}
