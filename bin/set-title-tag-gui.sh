#!/bin/bash
#als-desktop %f

video_path=$1

[ -f "$video_path" ] || exit 1

original_title=$(ffprobe -loglevel quiet -of default=nk=1:nw=1 -show_entries format_tags=title -- "$video_path")

title=$(kdialog --title="$0" --icon=edit-cut --inputbox "Title to set for $(realpath -- "$video_path"):" -- "$original_title") || exit 0

set-video-title.sh "$video_path" "$title"
