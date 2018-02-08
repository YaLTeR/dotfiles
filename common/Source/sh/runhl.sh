#!/usr/bin/env bash
set -ex

# Check your distribution to find out how it runs Steam.
# Replace 1 with 0 if it's not using Steam's bundled libraries.
USE_STEAM_BUNDLED_LIBRARIES=0

# Make sure the paths below do not contain spaces.

# Set this to the full path to the .steam folder, usually ~/.steam
# This folder should contain bin32 and steam folders/symlinks.
export STEAM_ROOT=~/.steam

# Set this to the path to your Half-Life folder, usually $STEAM_ROOT/steam/steamapps/common/Half-Life
export HL_ROOT=~/Half-Life

if [ "$USE_STEAM_BUNDLED_LIBRARIES" -eq 1 ]; then
	export PLATFORM=bin32
	export STEAM_RUNTIME=$STEAM_ROOT/$PLATFORM/steam-runtime

	export LD_LIBRARY_PATH=\
$HL_ROOT:\
$STEAM_ROOT/$PLATFORM:\
$STEAM_RUNTIME/i386/lib/i386-linux-gnu:\
$STEAM_RUNTIME/i386/lib:\
$STEAM_RUNTIME/i386/usr/lib/i386-linux-gnu:\
$STEAM_RUNTIME/i386/usr/lib:\
$STEAM_RUNTIME/amd64/lib/x86_64-linux-gnu:\
$STEAM_RUNTIME/amd64/lib:\
$STEAM_RUNTIME/amd64/usr/lib/x86_64-linux-gnu:\
$STEAM_RUNTIME/amd64/usr/lib:\
/usr/lib32
else
	export LD_LIBRARY_PATH=$HL_ROOT:/usr/lib32
fi

if [ -n "$FFMPEG_LIBRARY_PATH" ]; then
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$FFMPEG_LIBRARY_PATH
fi

export LD_PRELOAD=~/Source/rust/hlfixperf/target/i686-unknown-linux-gnu/release/libhlfixperf.so:/usr/lib32/libSDL2.so

if [ -n "$BXT" ]; then
	export LD_PRELOAD=~/Source/cpp/BunnymodXT/build/libBunnymodXT.so:$LD_PRELOAD
fi
if [ -n "$HLCAPTURE" ]; then
	export LD_PRELOAD=~/Source/rust/hl-capture/target/i686-unknown-linux-gnu/release/libhl_capture.so:$LD_PRELOAD
fi
if [ -n "$PRELOAD" ]; then
	export LD_PRELOAD=$PRELOAD:$LD_PRELOAD
fi

cd $HL_ROOT

if [ -n "$GDB" ]; then
	exec gdb ./hl_linux
else
	exec ./hl_linux -steam "$@"
fi
