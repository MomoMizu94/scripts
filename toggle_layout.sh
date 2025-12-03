#!/bin/bash

CURRENT=$(hyprctl getoption general:layout -j | jq -r '.str')

if [[ "$CURRENT" == "master" ]]; then
    hyprctl keyword general:layout dwindle
else
    hyprctl keyword general:layout master
fi

