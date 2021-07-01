#!/bin/sh

export WINEPREFIX=$HOME/.wine_osu
export WINEARCH=win32
# export STAGING_AUDIO_DURATION=80000
# export PULSE_LATENCY_MSEC=14

# Doesn't help the latency but somehow makes the playfield smoother.
export PIPEWIRE_LATENCY=64/44100

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
