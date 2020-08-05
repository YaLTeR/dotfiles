#!/usr/bin/fish

if test (count $argv) -ne 1
	echo "./"(basename (status -f)) "<refresh rate>"
else
	if test $XDG_SESSION_DESKTOP = "gnome"
		if test $argv[1] -eq 144
			# ~/source/c/gnome-monitor-config/build/src/gnome-monitor-config set -L -M DP-2 -p -m 2560x1440@143.99830627441406 -L -M DP-4 -x 2560 -y 360 -m 1920x1080@144.00076293945312
			~/source/c/gnome-monitor-config/build/src/gnome-monitor-config set -L -M DP-3 -p -m 2560x1440@143.99880981445312 -L -M DP-4 -x 2560 -y 360 -m 1920x1080@144.00125122070312
		else if test $argv[1] -eq 120
			# ~/source/c/gnome-monitor-config/build/src/gnome-monitor-config set -L -M DP-2 -p -m 2560x1440@119.99759674072266 -L -M DP-4 -x 2560 -y 360 -m 1920x1080@119.982177734375
			~/source/c/gnome-monitor-config/build/src/gnome-monitor-config set -L -M DP-3 -p -m 2560x1440@119.99809265136719 -L -M DP-4 -x 2560 -y 360 -m 1920x1080@119.98268890380859
		else
			echo "only 120 and 144 Hz is supported"
			exit 1
		end
	else
		xrandr --output DP-0 --mode 2560x1440 --rate $argv[1]
		xrandr --output DP-2 --mode 1920x1080 --rate $argv[1]
	end
end
