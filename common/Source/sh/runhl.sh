#!/bin/bash

export HL_ROOT=$HOME/Half-Life
export LD_LIBRARY_PATH=$HL_ROOT:/usr/lib32
export LD_PRELOAD=/usr/lib32/libSDL2.so
if [ -n "$PRELOAD" ]; then
	export LD_PRELOAD=$PRELOAD:$LD_PRELOAD
fi

cd $HL_ROOT
exec ./hl_linux -steam "$@"
#exec gdb ./hl_linux
