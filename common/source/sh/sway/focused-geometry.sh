#!/bin/sh
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
sh "$SCRIPT_DIR/focused.sh" | jq -r '.rect | "\(.x),\(.y) \(.width)x\(.height)"'
