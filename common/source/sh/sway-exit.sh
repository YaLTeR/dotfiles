#!/bin/sh

ANSWER="$(printf 'Yes\nNo' | dmenu -i -p 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -nb '#FFA800' -nf '#000000' -sb '#FFA800' -sf '#000000')"

if [ "$ANSWER" = "Yes" ]; then
	swaymsg exit
fi
