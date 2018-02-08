#!/usr/bin/bash

# Copy the current URL.
xdotool key --clearmodifiers F6 sleep 0.2 key --clearmodifiers ctrl+c

# Open it with mpv.
# xdotool key --clearmodifiers super+8 super+Return sleep 0.5 type --clearmodifiers "mpv --fullscreen --video-sync=display-resample \"$(xsel -o)\""
# xdotool key --clearmodifiers Return
exec mpv --video-sync=display-resample "$(xsel -o)"
