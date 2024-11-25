#!/bin/bash

# By default an mp3 is generated

# 'cut.sh ~/c.mp3' (no options) will create c.mp3.mp3 in the current directory, the title tag is conserved.
# 'cut.sh -r ~/c.mp3' will create c.mp3 in the current directory, the title tag is conserved.
# 'cut.sh ~/c.mp4 1' will create 'c.mp4 @ 0-01.00.mp3' in the current directory, the title tag will be: if source title tag is not empty then 'source title tag @ 0-01.00' else 'filename without extension @ 0-01.00'

# Output fullpath may be equal to input fullpath

# Usage: cut.sh a.mp3 3 1:20.21
# Usage: cut.sh b.mkv 3.5 (to get between 3.5 s and the end)
# Usage: cut.sh c.mp4
# The timestamp format is [[hour:]minute:]second[.decimal_part_of_second].

script_name=cut.sh # Must not contain whitespace

tmpdir=/tmp/$script_name
mkdir -p -- "$tmpdir" || exit 1




audio_track= # Track index among tracks of all types
subtitle_track= # Same
subtitle_track_restricted= # Track index among only subtitle tracks

open=

extension=mp3
audio_codec=default # libmp3lame
video_codec=

dir=$(pwd) # Cannot be '.' because of a kdialog bug: kdialog --getsavefilename ./a doesn't work as expected
choose_fullpath=
no_redundant_ext=

title_override=
choose_title=

ffmpeg_options=

while :; do
	case "$1" in
		-d|--directory) dir=$2; shift 2;;
		-cf|--choose-fullpath) choose_fullpath=true; shift;;
		# If source file is a.mp3 and destination would be a.mp3.mp3, it becomes a.mp3
		-r|--no-redundant-ext) no_redundant_ext=true; shift;;
		
		# The title tag of the output file is by default nothing if no title tag in source, and source title tag @ timestamps if there is a source title tag. Use --title to force a title, and --choose-title to get a GUI dialog to choose the title, containing either the argument of --title if present, or the automatically-determined title.
		-t|--title) title_override=$2; shift 2;;
		-ct|--choose-title) choose_title=true; shift;;
		
		-f|--format) IFS=, read -r extension audio_codec video_codec <<< "$2"; [ "$extension" -a "$audio_codec" ] || exit 1; shift 2;; # Argument of the form: file_extension_without_dot,audio_codec[,video_codec]. Video codec is necessary if the output has video, and must not be given if the output only has audio. For codecs, the special value 'default' is accepted (synonym 'd'). Examples: -f webm,opus,vp9 --format mp3,default
		#-v|--video) extension=mp4; audio_codec=aac; video_codec=h264; shift;;
		
		-a|--audio-track) [[ $2 =~ ^[0-9]+$ ]] && audio_track=$2; shift 2;; # All audio tracks are included if not given
		-s|--subtitle-track) [[ $2 =~ [0-9]+ ]] && subtitle_track=${2%,*}; subtitle_track_restricted=${2#*,}; shift 2;; # No subtitles are included if not given
		
		-op|--open) open=true; shift;;
		
		-o|--ffmpeg-options) ffmpeg_options=$2; shift 2;; # Example: -o '-q:a 3'
		
		-h|--help) cat -- "$0"; exit 0;;
		--) shift; break;;
		*) break;;
	esac
done

format-time() {
    IFS=: read -r s m h <<< "$(rev <<< "$1")"
    
    [ ! "$h" ] && h=0 || h=$(rev <<< "$h")
    [ ! "$m" ] && m=0 || m=$(rev <<< "$m")
    s=$(rev <<< "$s")
    
    LC_ALL=C awk "BEGIN { sum = $h * 3600 + $m * 60 + $s; printf(\"%d-%05.2f\", int(sum / 60), sum % 60) }"
}

[ "$1" ] || exit 1
[ "$3" -a -z "$2" ] && set -- "$1" 0 "$3"

interval=
[ "$2" ] && interval=" @ $(format-time "$2")"
[ "$3" ] && interval=$interval" - $(format-time "$3")"

filename=$(basename -- "$1")

if [ "$no_redundant_ext" -a -z "$interval" -a "$extension" = "${filename##*.}" ]; then
    output_path=${dir%/}/$filename
else
    output_path=${dir%/}/$filename$interval.$extension
fi

if [ "$choose_fullpath" ]; then
    output_path=$(kdialog --title="$script_name" --icon=edit-cut --getsavefilename -- "$output_path" 2> /dev/null) || exit
    [[ $output_path =~ ".$extension"$ ]] || exit 1
fi

tmp_output_path=$(dirname -- "$output_path")/${script_name}_tmp_$$.$extension

if [ "$title_override" ]; then
    title=$title_override
else
    title=$(ffprobe -loglevel quiet -of default=nk=1:nw=1 -show_entries format_tags=title -- "$1")
    [ "$title" ] && title=$title$interval || title=${filename%.*}$interval
fi

if [ "$choose_title" ]; then
    title=$(kdialog --title="$script_name" --icon=edit-cut --inputbox "Title tag of cut extract: $(printf =%.s {1..120})" -- "$title") || exit
fi

log_file=$tmpdir/$$_ffmpeg.log
progress_file=$tmpdir/$$_ffmpeg_progress.log

set -f # Disable globbing so the question mark in "-map 0:v?" is not interpreted
if [ "$video_codec" ]; then
    if [ "$subtitle_track" ]; then
        subtitle_codec=$(ffprobe -loglevel quiet -of default=nk=1:nw=1 -show_entries stream=codec_name -select_streams "$subtitle_track" -- "$1")
        picture_subtitles_to_burn=
        text_subtitles_to_burn=
        if [[ $subtitle_codec =~ ^(hdmv_pgs_subtitle|xsub|dvd_subtitle|dvb_subtitle)$ ]]; then
            picture_subtitles_to_burn=true
        else
            text_subtitles_to_burn=$tmpdir/$$_video
            ln -s -- "$1" "$text_subtitles_to_burn"
        fi
    fi
    ffmpeg_command=(ffmpeg -stats_period 3 -progress "$progress_file" -y $([ "$2" ] && echo -ss "$2") $([ "$3" ] && echo -to "$3") -copyts -i "$1" $([ "$2" ] && echo -ss "$2") $([ "$3" ] && echo -to "$3") $([[ $video_codec =~ ^(default|d)$ ]] || echo -vcodec $video_codec) $([[ $audio_codec =~ ^(default|d)$ ]] || echo -acodec $audio_codec) $([ "$picture_subtitles_to_burn" ] && echo -filter_complex [0:v][0:$subtitle_track]overlay[v] -map [v] || echo -map 0:v?) $([ "$audio_track" ] && echo -map 0:$audio_track || echo -map 0:a?) $([ "$text_subtitles_to_burn" ] && echo -vf subtitles=$text_subtitles_to_burn:stream_index=$subtitle_track_restricted) -metadata title="$title" $ffmpeg_options -ac 2 -- "$tmp_output_path")
else # Audio only
    ffmpeg_command=(ffmpeg -stats_period 3 -progress "$progress_file" -y $([ "$2" ] && echo -ss "$2") $([ "$3" ] && echo "-to $3") -copyts -i "$1" $([ "$2" ] && echo -ss "$2") $([ "$3" ] && echo "-to $3") -vcodec copy $([[ $audio_codec =~ ^(default|d)$ ]] || echo -acodec $audio_codec) $([ "$audio_track" ] && echo -map 0:v? -map -0:V? -map 0:$audio_track) -metadata title="$title" $ffmpeg_options -- "$tmp_output_path")
fi
set +f

echo "Logging ffmpeg output to: $log_file" 1>&2
echo "Running command: ${ffmpeg_command[*]}" &>> "$log_file"
"${ffmpeg_command[@]}" &>> "$log_file" &

tail -F --pid=$! -- "$progress_file" 2> /dev/null | grep -E --line-buffered '^speed=|^out_time=' 1>&2 &

if ! wait -n %?ffmpeg_command; then
    rm -f -- "$tmp_output_path"
    exit 1
fi

mv -f -- "$tmp_output_path" "$output_path"

printf '%s\n' "$output_path"

notify-send -i edit-cut -- "$script_name" "Cut finished for $output_path"

echo "Cut succeeded" 1>&2

if [ "$open" ]; then
    cd -- "$(dirname -- "$output_path")"
    mpv --loop-file --pause --force-window --window-minimized -- "$output_path" &>/dev/null & disown
fi
