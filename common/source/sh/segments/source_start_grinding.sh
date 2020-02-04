#!/bin/sh
set -e

# This script sets up segmenting configs and folders and proceeds to monitor the save and demo for
# changes, reporting the time of each successful attempt. An attempt is successful if a save was
# made.
#
# Don't forget to `exec source_segments` at least once. Restarting the script afterwards (for
# example, to grind a different segment) doesn't require re-execing since all variable parts (demo
# and save filenames) are contained in their own mini-cfgs updated by the script.
#
# Prerequisites:
# - wine (for Listdemo-), inotifywait from inotify-tools,
# - source_segments.cfg in the same folder as the script,
# - Listdemo.exe (Listdemo-) in the same folder as the script,
# - A previous segment save in the SAVE folder of the mod. For example, if the segment number is 23,
#   the script will look for a save called 022-*.sav and use the first one. It will print the one it
#   ends up using.

# Calls Listdemo- in $1 on the given demo file in $2 and returns its output.
# Both of the two arguments must be full paths.
call_listdemo () {
	TEMP_FOLDER="$(mktemp -d)"

	cp "$DEMO_FILE" "$TEMP_FOLDER"
	DEMO_FILE="$TEMP_FOLDER/$(basename "$DEMO_FILE")"

	cd "$TEMP_FOLDER"
	echo "" | WINEDEBUG=-all wine "$LISTDEMO" "$DEMO_FILE"

	rm -rf "$TEMP_FOLDER"
}

# Calls Listdemo- in $1 on the given demo file in $2 and returns the demo time and tick count,
# separated with space.
# Both of the two arguments must be full paths.
demo_time_and_ticks () {
	call_listdemo "$@" | grep flag | awk '{ print $8 " " $10 }'
}

main () {
	if [ "$#" -ne "2" ]; then
		echo "Usage: $0 </path/to/mod/folder> <segment #>"
		exit 1
	fi

	NICKNAME="y"
	SEGMENT_NUMBER=$(printf "%03d" "$2")
	SEGMENT_NAME="$SEGMENT_NUMBER-$NICKNAME-s"

	SCRIPT_PATH="$(dirname "$0")"

	LISTDEMO="$(realpath "$SCRIPT_PATH/Listdemo.exe")"
	if [ ! -f "$LISTDEMO" ]; then
		echo "$LISTDEMO does not exist"
		exit 1
	fi

	RECORD_CFG="record_segment.cfg"
	LOAD_CFG="load_segment.cfg"
	LOAD_NEXT_CFG="load_next_segment.cfg"
	SAVE_CFG="save_segment.cfg"
	MAIN_CFG="source_segments.cfg"
	ATTEMPTS_FOLDER_NAME="attempts"

	SEGMENT_NUMBER_DECIMAL=$(printf "%d" "$2")
	PREVIOUS_SEGMENT_NUMBER=$(printf "%03d" $((SEGMENT_NUMBER_DECIMAL - 1)))

	CFG_FOLDER="$1/cfg"
	if [ ! -d "$CFG_FOLDER" ]; then
		echo "$CFG_FOLDER does not exist"
		exit 1
	fi

	SAVE_FOLDER="$1/SAVE"
	if [ ! -d "$SAVE_FOLDER" ]; then
		echo "$SAVE_FOLDER does not exist"
		exit 1
	fi

	PREVIOUS_SEGMENT_SAVE="$(set -- "$SAVE_FOLDER/$PREVIOUS_SEGMENT_NUMBER-"*.sav; echo "$1")"
	if [ ! -f "$PREVIOUS_SEGMENT_SAVE" ]; then
		echo "$SAVE_FOLDER/$PREVIOUS_SEGMENT_NUMBER-* does not exist"
		exit 1
	fi

	PREVIOUS_SEGMENT_SAVE="$(basename "${PREVIOUS_SEGMENT_SAVE%.sav}")"
	echo "Using $PREVIOUS_SEGMENT_SAVE"

	ATTEMPTS_FOLDER="$1/$ATTEMPTS_FOLDER_NAME"
	CURRENT_ATTEMPT_FOLDER="$ATTEMPTS_FOLDER/$SEGMENT_NUMBER"
	mkdir -p "$CURRENT_ATTEMPT_FOLDER"

	MAIN_CFG="$SCRIPT_PATH/$MAIN_CFG"
	if [ ! -f "$MAIN_CFG" ]; then
		echo "$MAIN_CFG does not exist"
		exit 1
	fi

	cp "$MAIN_CFG" "$CFG_FOLDER/"
	echo "record \"$CURRENT_ATTEMPT_FOLDER/$SEGMENT_NAME\"" > "$CFG_FOLDER/$RECORD_CFG"
	echo "save \"$SEGMENT_NAME\"" > "$CFG_FOLDER/$SAVE_CFG"
	echo "load \"$PREVIOUS_SEGMENT_SAVE\"" > "$CFG_FOLDER/$LOAD_CFG"
	echo "load \"$SEGMENT_NAME\"" > "$CFG_FOLDER/$LOAD_NEXT_CFG"

	SAVE_FILE="$SAVE_FOLDER/$SEGMENT_NAME.sav"
	DEMO_FILE="$(realpath "$CURRENT_ATTEMPT_FOLDER/$SEGMENT_NAME.dem")"

	touch "$SAVE_FILE"
	while inotifywait -qe close_write "$SAVE_FILE" >/dev/null 2>&1; do
		# Warning: possible race condition (demo file gets written to before two of the next lines).
		# This isn't really an issue thanks to the wait 100 between the save and the stop in a usual
		# segment stopping bind.
		touch "$DEMO_FILE"
		inotifywait -qe close_write "$DEMO_FILE" >/dev/null 2>&1

		# Get the ticks and the time in two separate variables.
		read -r TIME TICKS <<EOF
$(demo_time_and_ticks "$LISTDEMO" "$DEMO_FILE")
EOF

		echo "Segment time: $TIME ($TICKS ticks)."
	done
}

main "$@"
