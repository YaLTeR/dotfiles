#!/usr/bin/bash

if [[ -z $DISPLAY  ]]; then
	exec pinentry-curses "$@"
else
	exec pinentry-gtk-2 "$@"
fi
