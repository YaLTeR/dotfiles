#!/usr/bin/fish

function battery
	set full (cat /sys/class/power_supply/BAT0/charge_full)
	set current (cat /sys/class/power_supply/BAT0/charge_now)
	set percentage (math $current "* 100 /" $full)

	echo '{"full_text": "'$percentage'"}'
end

function time
	echo '{"full_text": "'(date '+%H:%M')'"}'
end

echo '{"version": 1}'
echo '['
echo '[],'

while true
	echo '['
	battery
	echo ','
	time
	echo '],'

	sleep 5
end
