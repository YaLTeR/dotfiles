#!/bin/sh

man -k . | rofi -dmenu | sed -E 's/^(\S+)\s+\((\S+)\).*/\2 \1/' | xargs man
