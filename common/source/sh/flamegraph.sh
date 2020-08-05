#!/bin/sh
set -e

main () {
	if [ "$#" -ne "1" ]; then
		echo "Usage: $0 <perf.data>"
		exit 1
	fi

	BASENAME="${1%.*}"

	echo "Launching perf script..."
	perf script -i "$1" > "$BASENAME.perf"

	echo "Launching stackcollapse-perf.pl..."
	# ~/source/pl/FlameGraph/stackcollapse-perf.pl "$BASENAME.perf" > "$BASENAME.folded"
	~/source/rs/inferno/target/release/inferno-collapse-perf "$BASENAME.perf" > "$BASENAME.folded"

	echo "Launching flamegraph.pl..."
	# ~/source/pl/FlameGraph/flamegraph.pl "$BASENAME.folded" > "$BASENAME.svg"
	~/source/rs/inferno/target/release/inferno-flamegraph "$BASENAME.folded" > "$BASENAME.svg"

	echo "Launching Firefox..."
	firefox "$BASENAME.svg"
}

main "$@"
