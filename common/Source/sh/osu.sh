#!/usr/bin/fish

set -x WINEPREFIX $HOME/.wine_osu
set -x WINEARCH win32

if math (count $argv) ">= 1" > /dev/null
	if [ $argv[1] = "k" ]
		exec wineserver -k
	else
		exec wine '/mnt/hdd/Source/osu! stuff/osufx/osu!win/bin/x86/PublicNoUpdate/osu!.exe'
	end
else
	exec wine '/mnt/hdd/Games/osu!/osu!.exe'
end
