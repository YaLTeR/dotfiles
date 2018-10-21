#!/usr/bin/fish

set filename $HOME"/Screenshots/"(date +%F-%T)".png"

slurp | grim -c -g - $filename

if test -f $filename
	# set url (imgurbash2 $filename)
	# set link (echo $url[1] | cut -f1 -d " ")
	# if [ $status = "0" ]
	# 	notify-send $link
	# 	echo -n $link | xsel -i
	# 	echo -n $link | xsel -ib
	# end

	wl-copy < $filename
	# notify-send "Screenshot captured."
end
