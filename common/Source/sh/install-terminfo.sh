#! /usr/bin/bash
set -euo pipefail
IFS=$'\n\t'

function main {
	if [[ $# -ne "1" ]]; then
		echo "./install-terminfo.sh <ssh host>"
	else
		local TEMPFILE=$(ssh "$1" "mktemp")
		infocmp | ssh "$1" "cat > \"$TEMPFILE\" && tic -x \"$TEMPFILE\""
	fi
}

main $@
