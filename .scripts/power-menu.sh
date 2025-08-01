#!/bin/bash

PROCESS_NAME="/bin/bash $0"
PID_COUNT=$(pgrep -xfc "$PROCESS_NAME")

if [[ $PID_COUNT != 1 ]]; then
	echo "killit"
	exit
fi

OPTION_STRING="\n\n\n\n"
SELECTED=$(echo -e $OPTION_STRING | wofi --dmenu -k /dev/null -c $HOME/.config/wofi/power-menu-config.conf -s $HOME/.config/wofi/power-menu-style.css)

case $SELECTED in
    "")
	swaymsg exit
	;;
    "")
	systemctl suspend
	;;
    "")
	systemctl reboot
	;;
    "")
	systemctl poweroff
	;;
esac
