#!/bin/sh
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
sh "$SCRIPT_DIR/focused-geometry.sh" | grim -cg- -
