#!/bin/bash

# Declare paths for images
IMGPATH="$HOME/ScreenShots/$(date +'%s_grim.png')"

# Get focused monitor
FOCUSED=$(hyprctl monitors -j | $HOME/.scripts/getactivemonitor.py)

# Take a screenshot of focused monitor
grim -o $FOCUSED $IMGPATH

# Copy selected area to clipboard
wl-copy -t image/png < $IMGPATH
