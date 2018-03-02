#!/bin/sh

export WINEPREFIX=$HOME/.wine_osu
export WINEARCH=win32

if [ $# -ge 1 ]
then
	if [ "$1" = "k" ]
	then
		exec wineserver -k
	elif [ "$1" = "a" ]
	then
		exec wine '/mnt/hdd/Source/osu! stuff/osufx/osu!win/bin/x86/PublicNoUpdate/osu!.exe'
	else
		exec wine '/mnt/hdd/Games/osu!/osu!.exe' "$@"
	fi
else
	exec wine '/mnt/hdd/Games/osu!/osu!.exe'
fi
