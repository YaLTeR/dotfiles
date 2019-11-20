#!/bin/sh
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
REGION="$(sh "$SCRIPT_DIR/visible-geometry.sh" | slurp)" || exit 1
wf-recorder -c h264_vaapi -d /dev/dri/renderD129 --to-yuv -g "$REGION" -f "$1"
