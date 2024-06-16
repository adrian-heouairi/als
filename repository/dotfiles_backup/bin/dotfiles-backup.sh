#!/bin/bash

# TODO /home/abc/.config/audacious
# With regret I can't include /home/abc/.config/plasma-org.kde.plasma.desktop-appletsrc (dock config)
# /home/abc/.local/share/kglobalaccel?

#source ~/.local/als/source/als-bin.sh || exit 1

mkdir -p ~/.local/als-custom-60-from-aetu2/packages-conf/dotfiles

# Paths are relative to ~, no trailing slash for directories
exclude=(
.config/gtk-3.0/bookmarks
)

# Paths are relative to ~, put a trailing slash for directories
include=(
.config/eog/
.config/fcitx5/
.config/gtk-2.0/
.config/gtk-3.0/
.config/gtk-4.0/
.config/mozc/
.config/tagaini.net/
.config/vlc/
.config/xsettingsd/
.config/arkrc
.config/Audaciousrc
.config/dolphinrc
.config/gtkrc
.config/gtkrc-2.0
.config/gwenviewrc
.config/kaccessrc
.config/katerc
.config/kcminputrc
.config/kded5rc
.config/kdeglobals
.config/kglobalshortcutsrc
.config/kiorc
.config/klaunchrc
.config/klipperrc
.config/konsolerc
.config/krunnerrc
.config/kservicemenurc
.config/ktrashrc
.config/kwinrc
.config/kwinrulesrc
.config/kxkbrc
.config/okularrc
.config/plasma_calendar_holiday_regions
.config/plasma-localerc
.config/plasmanotifyrc
.config/plasmaparc
.config/spectaclerc
.config/systemsettingsrc
.config/Trolltech.conf
.local/share/konsole/Profile' '1.profile
.local/share/kxmlgui5/
.local/share/Tagaini' 'Jisho/
.gtkrc-2.0
)

# -r instead of -a because we don't want -l so if ~/.bashrc is a symlink, we copy the destination of that symlink instead
cmd=(rsync --delete --delete-excluded -r --prune-empty-dirs --include='*'/)


cmd+=("${exclude[@]/#/'--exclude=/'}")

for i in "${include[@]}"; do
    if [[ $i =~ /$ ]]; then
        cmd+=("--include=/$i***")
    else
        cmd+=("--include=/$i")
    fi
done


cmd+=(--exclude='*' ~/ ~/.local/als-custom-60-from-aetu2/packages-conf/dotfiles/)

exec "${cmd[@]}"
