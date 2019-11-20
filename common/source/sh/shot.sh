#!/usr/bin/fish

set filename $HOME"/Screenshots/"(date +%F-%T)".png"

if test (count $argv) -ge 1
	if test $argv[1] = "--window"
		gnome-screenshot -w -f $filename
	else if test $argv[1] = "--screen"
		gnome-screenshot -f $filename
	end
else
	sleep 0.2; gnome-screenshot -a -f $filename
end

if test -f $filename
	# set url (imgurbash2 $filename)
	# set link (echo $url[1] | cut -f1 -d " ")
	# if [ $status = "0" ]
	# 	notify-send $link
	# 	echo -n $link | xsel -i
	# 	echo -n $link | xsel -ib
	# end

	xclip -selection clipboard -t image/png $filename
	notify-send "Screenshot captured."
end
