#!/bin/sh

sudo sed -i 's/^load-module module-udev-detect fixed_latency_range=yes$/load-module module-udev-detect/' /etc/pulse/default.pa && pulseaudio --kill && pulseaudio --start
