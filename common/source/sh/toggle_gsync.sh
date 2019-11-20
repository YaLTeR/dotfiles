#!/usr/bin/fish

set gsync_enabled (nvidia-settings -q AllowGSYNC | grep -o -P '(?<= )(0|1)(?=.$)')

if test $gsync_enabled = "0"
	set new_value "1"
else
	set new_value "0"
end

nvidia-settings -a AllowGSYNC=$new_value
