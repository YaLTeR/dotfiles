#!/usr/bin/fish

set filename $HOME"/Screenshots/"(date +%F-%T)".png"

if test (count $argv) -ge 1
	if test $argv[1] = "--screen"
		grim - > $filename
	else
		exit 1
	end
else
	slurp | grim -cg- - > $filename
end

if test -f $filename
	# set url (imgurbash2 $filename)
	# set link (echo $url[1] | cut -f1 -d " ")
	# if [ $status = "0" ]
	# 	notify-send $link
	# 	echo -n $link | xsel -i
	# 	echo -n $link | xsel -ib
	# end

	wl-copy < $filename
	notify-send -i $filename "Screenshot captured."
end
