#!/bin/sh
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
REGION="$(sh "$SCRIPT_DIR/visible-geometry.sh" | slurp)" || exit 1
grim -g "$REGION" -
