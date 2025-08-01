#!/bin/bash

# Declare paths for images
FULLPATH="$HOME/ScreenShots/fullscreen.png"
IMGPATH="$HOME/ScreenShots/$(date +'%s_grim.png')"

# Get focused monitor
FOCUSED=$(hyprctl monitors -j | $HOME/.scripts/getactivemonitor.py)

# Take a screenshot of focused monitor
grim -o $FOCUSED $FULLPATH

# Open it and make it run in background
# Make sure window rules are set correctly
feh $FULLPATH &

# Take a snip of fullscreen and save it
grim -g "$(slurp)" $IMGPATH

if [ $? -ne 0 ]; then
	kill $!
	exit 1
fi

# kill feh
kill $!

# Copy selected area to clipboard
wl-copy -t image/png < $IMGPATH
