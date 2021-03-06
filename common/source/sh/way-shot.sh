#!/usr/bin/fish

set filename $HOME"/Screenshots/"(date +%F-%T)".png"
set script_dir (dirname (readlink -f (status filename)))

if test (count $argv) -ge 1
	if test $argv[1] = "--window"
		sh $script_dir/sway/screenshot-focused.sh > $filename || rm $filename
	else if test $argv[1] = "--screen"
		grim - > $filename || rm $filename
	else
		exit 1
	end
else
	sh $script_dir/sway/screenshot-pick-visible.sh > $filename || rm $filename
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
