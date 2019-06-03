#!/usr/bin/fish

set filename $HOME"/Recordings/"(date +%F-%T)".mp4"
set script_dir (dirname (readlink -f (status filename)))

if test (count $argv) -ge 1
	if test $argv[1] = "--window"
		sh $script_dir/sway/record-focused.sh $filename
	else
		exit 1
	end
else
	sh $script_dir/sway/record-pick-visible.sh $filename
end

if test -f $filename
	notify-send "Recording captured."
end
