#!/bin/sh

if [ -z "$WAYLAND_DISPLAY" ]; then
	PROGRAM=xfreerdp
else
	PROGRAM=wlfreerdp
fi

exec $PROGRAM \
	/v:"$1" \
	/u:"$2" \
	+home-drive \
	/size:1920x1080
