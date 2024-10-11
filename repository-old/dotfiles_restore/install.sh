#!/bin/bash

source ~/.local/als/source/als-bin.sh || exit 1

exec ~/.local/als/repository/dotfiles_restore/bin/dotfiles-restore.sh
