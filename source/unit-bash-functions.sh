#!/bin/bash

# This supports source arrays with holes (some elements have been unset).
# Only for integer-indexed arrays.
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

print_info() {
    printf '\e[1;32m%s\e[m\n' "$*" >&2
}

print_err_exit() {
    print_err "$1"
    exit "${2:-1}" # $2 or 1 if $2 is not set
}

# Input is \n-separated.
# If there are arguments after shift, use $* without quotes. Otherwise use stdin.
# Example: input_to_array x $'a\nb' c results in x=(a b c).
input_to_array() {
    local var_name=$1
    shift
    old_ifs=$IFS
    IFS=$'\n'
    local tmp
    if (($# > 0)); then
        tmp=($*)
    else
        tmp=($(cat))
    fi
    IFS=$old_ifs
    copy_array tmp "$var_name"
}

# This might work with local arrays
remove_val_from_array_no_hole() {
    local -n arr_ref=$1 # Pass the array var name as $1
    local value=$2
    local temp_array=()
    
    for element in "${arr_ref[@]}"; do
        [ "$element" != "$value" ] && temp_array+=("$element")
    done
    
    arr_ref=("${temp_array[@]}")
}
