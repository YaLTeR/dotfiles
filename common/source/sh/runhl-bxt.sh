#!/bin/bash

export HL_ROOT="$HOME/Half-Life"
export LD_PRELOAD=~/source/cpp/BunnymodXT/build/libBunnymodXT.so
if [ -n "$PRELOAD" ]; then
	export LD_PRELOAD=$PRELOAD:$LD_PRELOAD
fi

cd $HL_ROOT
# exec perf record --call-graph dwarf,65528 -F 100 -D 5000 ./hl_linux -steam "$@"
exec ~/.steam/bin/steam-runtime/run.sh ./hl_linux -steam "$@"
# exec ~/.steam/bin/steam-runtime/run.sh gdb ./hl_linux
