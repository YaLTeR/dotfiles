#!/bin/sh
notify-send 'CPU Usage Top' "$(ps achx -o '%C%% %c' --sort -%cpu | head -n4)"
