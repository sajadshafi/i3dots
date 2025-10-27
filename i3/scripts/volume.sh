#!/bin/bash

default_step=5
bar_color="#D3C6AA"
volume_step="${1:-$default_step}"
max_volume=100

# --- Helper Functions ---

function get_volume {
    pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1
}

function get_mute {
    pactl get-sink-mute @DEFAULT_SINK@ | grep -Po '(?<=Mute: )(yes|no)'
}

function get_volume_icon {
    volume=$(get_volume)
    mute=$(get_mute)
    if [ "$volume" -eq 0 ] || [ "$mute" == "yes" ]; then
        volume_icon=""
    elif [ "$volume" -lt 50 ]; then
        volume_icon=""
    else
        volume_icon=""
    fi
}

function show_volume_notif {
    volume=$(get_volume)
    get_volume_icon
    dunstify -i audio-volume-muted-blocking -t 1000 -r 2593 -u normal "$volume_icon $volume%" -h int:value:$volume -h string:hlcolor:$bar_color
}

function show_help {
    cat <<EOF
Usage: $0 <action> [step]

Actions:
  up         Increase volume (default step: $default_step)
  down       Decrease volume (default step: $default_step)
  mute       Toggle mute

Optional:
  step       Percentage step value (e.g., 2.5, 10)

Examples:
  $0 up 10
  $0 down
  $0 mute
  $0 --help

EOF
}

# --- Main ---

action="$1"
step="${2:-$default_step}"

case "$action" in
    up)
        pactl set-sink-mute @DEFAULT_SINK@ 0
        volume=$(get_volume)
        if [ $((volume + step)) -gt $max_volume ]; then
            pactl set-sink-volume @DEFAULT_SINK@ $max_volume%
        else
            pactl set-sink-volume @DEFAULT_SINK@ "+${step}%"
        fi
        show_volume_notif
        ;;

    down)
        pactl set-sink-volume @DEFAULT_SINK@ "-${step}%"
        show_volume_notif
        ;;

    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        show_volume_notif
        ;;

    -h|--help)
        show_help
        ;;

    *)
        echo "❌ Invalid action: '$action'"
        echo "Use --help to see available options."
        exit 1
        ;;
esac

