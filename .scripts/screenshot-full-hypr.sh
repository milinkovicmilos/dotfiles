#!/bin/bash

# Declare paths for images
IMGPATH=/home/rey/ScreenShots/$(date +'%s_grim.png')

# Get focused monitor
FOCUSED=$(hyprctl monitors -j | /home/rey/Scripts/getactivemonitor.py)

# Take a screenshot of focused monitor
grim -o $FOCUSED $IMGPATH

# Copy selected area to clipboard
wl-copy -t image/png < $IMGPATH
