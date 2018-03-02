#!/usr/bin/fish

if test (count $argv) -ne 1
	echo "./"(basename (status -f)) "<refresh rate>"
else
	xrandr --output DP-0 --mode 2560x1440 --rate $argv[1]
	xrandr --output DP-2 --mode 1920x1080 --rate $argv[1]
end
