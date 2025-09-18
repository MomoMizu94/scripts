#!/usr/bin/env bash
# Pick a color from screen and copy its HEX value to clipboard  

set -euo pipefail

# Tool detection
command -v xcolor >/dev/null || { notify-send "Colorpicker Tool Missing" "'xcolor' Tool Is Not Installed!"; exit 1; }
command -v xclip >/dev/null || { notify-send "Colorpicker Tool Missing" "'xclip' Tool Is Not Installed!"; exit 1; }

HEX_VALUE="$(xcolor --format HEX)"

# Copy to clipboard
printf "%s" "$HEX_VALUE" | xclip -selection clipboard

# Pango markup to show copied color as a swatch
if command -v notify-send >/dev/null; then

    # Swatch for the notification
    SWATCH="<span foreground=\"$HEX_VALUE\"> ████</span>"

    # Notification
    notify-send -a "Color Picker" -t 10000 "Color Copied To Clipboard!" "$SWATCH    $HEX_VALUE" \
        -h string:x-canonical-private-synchronous:color-picker
fi
