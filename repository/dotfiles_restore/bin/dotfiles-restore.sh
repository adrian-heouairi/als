#!/bin/bash

source ~/.local/als/source/als-bin.sh || exit 1

src=~/.local/als-custom-60-from-aetu2/packages-conf/dotfiles

[ -d "$src" ] || exit 0

exec rsync -rl "$src"/ ~/
