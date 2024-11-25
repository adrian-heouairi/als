#!/bin/bash

file=$1

line=$(cat -- "$file" | fzf) || exit 1

line_number=$(grep -nFxm1 -- "$line" "$file" | cut -d: -f1)

code --goto "$file:$line_number"
