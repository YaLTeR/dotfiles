#!/usr/bin/fish

function battery
	set full (cat /sys/class/power_supply/BAT0/charge_full)
	set current (cat /sys/class/power_supply/BAT0/charge_now)
	set percentage (math $current "* 100 /" $full)

	echo '{"full_text": "'$percentage'%"}'
end

function time
	echo '{"full_text": "'(date '+%H:%M')'"}'
end

function wifi_info -a device
	begin
		set -l IFS :
		nmcli -t device | grep $device | read -a info
	end

	switch $info[3]
		case unavailable
			set wifi_status off 
		case disconnected
			set wifi_status disconnected
		case connecting'*'
			set wifi_status connecting
		case connected
			set wifi_status connected
	end

	echo $wifi_status
	echo $info[4]
end

function wifi
	set DEVICE wlp2s0
	set info (wifi_info $DEVICE)

	if string match $info[1] 'connected'
		set output $info[2]
	else
		set output $info[1]
	end

	echo '{"full_text": "'$output'"}'
end

echo '{"version": 1}'
echo '['
echo '[],'

while true
	echo '['
	# wifi
	# echo ','
	battery
	echo ','
	time
	echo '],'

	sleep 5
end
