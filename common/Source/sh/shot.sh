#!/usr/bin/fish

set filename $HOME"/Screenshots/"(date +%F-%T)".png"

if math (count $argv) ">= 1" > /dev/null
	if [ $argv[1] = "--window" ]
		maim -i (xdotool getactivewindow) $filename
	else if [ $argv[1] = "--screen" ]
		maim $filename
	end
else
	maim -s $filename
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
