#!/bin/sh
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
REGION="$(sh "$SCRIPT_DIR/focused-geometry.sh")"
wf-recorder -c h264_vaapi -d /dev/dri/renderD129 --to-yuv -g "$REGION" -f "$1"
