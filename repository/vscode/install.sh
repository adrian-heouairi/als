#!/bin/bash

wget -O /tmp/als-vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'

sudo apt install -y /tmp/als-vscode.deb

#mkdir -p ~/.config/Code/User/
#[ -e ~/.config/Code/User/settings.json ] || cp -f -- "$(linux-setup-get-resources-path.sh)"/vscode/{keybindings,settings}.json ~/.config/Code/User/
