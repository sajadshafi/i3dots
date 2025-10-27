#!/bin/bash

default_step=5
bar_color="#D3C6AA"
brightness_step="${2:-$default_step}"

# --- Helper Functions ---

function get_brightness {
    brightnessctl | grep -Po '([0-9]{1,3}(?=%))' | head -n 1
}

function get_brightness_icon {
    brightness_icon=""
}

function show_brightness_notif {
    brightness=$(get_brightness)
    get_brightness_icon
    dunstify -t 1000 -r 2593 -u normal "$brightness_icon $brightness%" -h int:value:$brightness -h string:hlcolor:$bar_color
}

function show_help {
    cat <<EOF
Usage: $0 <action> [step]

Actions:
  up         Increase brightness (default: $default_step)
  down       Decrease brightness (default: $default_step)

Optional:
  step       Percentage step value (e.g., 2.5, 10)

Examples:
  $0 up 10
  $0 down
  $0 --help

EOF
}

# --- Main ---

action="$1"
step="${2:-$default_step}"

case "$action" in
    up)
        echo "${step}"
        brightnessctl set "+${step}%"
        show_brightness_notif
        ;;

    down)
        echo "${step}"
        brightnessctl set "${step}%-"
        show_brightness_notif
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

