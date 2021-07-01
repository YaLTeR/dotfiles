#!/bin/bash

export HL_ROOT="/mnt/hdd/Games/SteamLibraryLinux/steamapps/common/Half-Life"
export LD_LIBRARY_PATH="$HL_ROOT:$LD_LIBRARY_PATH"
# export LD_PRELOAD=~/source/cpp/BunnymodXT/build/libBunnymodXT.so
# export LD_PRELOAD=~/source/cpp/BunnymodXT/build_release/libBunnymodXT.so
# export LD_PRELOAD=~/source/cpp/BunnymodXT/build_flatpak/libBunnymodXT.so
# export LD_PRELOAD=/var/home/yalter/.var/app/org.gnome.Builder/cache/gnome-builder/projects/BunnymodXT/builds/rs.bxt.BunnymodXT.json-flatpak-org.freedesktop.Sdk-x86_64-20.08-master/libBunnymodXT.so
export LD_PRELOAD=~/source/rs/bxt-rs/target/i686-unknown-linux-gnu/debug/libbxt_rs.so
# export LD_PRELOAD=~/source/rs/bxt-rs/target/i686-unknown-linux-gnu/debug/libbxt_rs.so:~/source/cpp/BunnymodXT/build/libBunnymodXT.so
# export LD_PRELOAD=~/source/rs/bxt-rs/target/i686-unknown-linux-gnu/release/libbxt_rs.so:~/source/cpp/BunnymodXT/build_release/libBunnymodXT.so
# export LD_PRELOAD=~/source/rs/bxt-rs/target/i686-unknown-linux-gnu/release/libbxt_rs.so

export LD_PRELOAD=~/source/rs/hlfixperf/target/i686-unknown-linux-gnu/release/libhlfixperf.so:$LD_PRELOAD
if [ -n "$PRELOAD" ]; then
	export LD_PRELOAD=$PRELOAD:$LD_PRELOAD
fi

export SteamEnv=1

cd $HL_ROOT
# exec perf record --call-graph dwarf,65528 -F 100 -D 5000 ./hl_linux -steam "$@"
exec ~/.steam/bin/steam-runtime/run.sh ./hl_linux -steam "$@"
# exec ~/.steam/bin/steam-runtime/run.sh ~/source/cpp/rr/install/bin/rr record ./hl_linux -steam "$@"
# exec ~/.steam/bin/steam-runtime/run.sh gdb ./hl_linux
