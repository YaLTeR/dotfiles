#!/bin/sh
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
patch /usr/share/X11/xkb/symbols/ctrl "$SCRIPT_DIR/ctrl.patch"
patch /usr/share/X11/xkb/rules/base "$SCRIPT_DIR/base.patch"
patch /usr/share/X11/xkb/rules/evdev "$SCRIPT_DIR/evdev.patch"
