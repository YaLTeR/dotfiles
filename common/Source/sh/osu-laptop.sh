#!/bin/sh

export WINEPREFIX=$HOME/.wine_osu
export WINEARCH=win32

if [ $# -ge 1 ]
then
	if [ "$1" = "k" ]
	then
		exec wineserver -k
	else
		exec wine "$WINEPREFIX/drive_c/Program Files/osu!/osu!.exe" "$@"
	fi
else
	exec wine "$WINEPREFIX/drive_c/Program Files/osu!/osu!.exe"
fi
