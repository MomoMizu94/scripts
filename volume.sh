#!/bin/sh

# Simple volume control script with notify-send

# Adjust the volume in 5% inceremnts
STEP=${STEP:-5}

# Command list
case "$1" in
    # Volume up 5%
    up)
        pactl set-sink-volume @DEFAULT_SINK@ +${STEP}% ;;

    # Volume down 5%
    down)
        pactl set-sink-volume @DEFAULT_SINK@ -${STEP}% ;;

    # Mute volume
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle ;;

    # Instructions
    *)
        echo "Usage: $0 {up|down|mute}" >&2; exit 2 ;;
esac

MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oE '[0-9]{1,3}%' | head -n1 | tr -d '%')

if [ "$1" = "mute" ]; then
    if [ "$MUTED" = "yes" ]; then
        notify-send -i audio-volume-muted "Volume Control" "Volume has been Muted!"
    else
        notify-send -i audio-volume-medium "Volume Control" "Volume has been Unmuted! \nCurrent Volume is: ${VOLUME}%"
    fi
else
    if [ "$MUTED" = "yes" ]; then
        notify-send -i audio-volume-muted "Volume Control" "Muted!"
    else
        notify-send -i audio-volume-high "Volume Control" "Current Volume is: ${VOLUME}%"
    fi
fi
