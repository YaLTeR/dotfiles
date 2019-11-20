#!/bin/sh

sudo sed -i 's/^load-module module-udev-detect$/load-module module-udev-detect fixed_latency_range=yes/' /etc/pulse/default.pa && pulseaudio --kill && pulseaudio --start
