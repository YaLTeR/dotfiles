#!/bin/sh
swaymsg -t get_tree | jq -r 'recurse(.nodes[]?, .floating_nodes[]?) | select(.visible or (.type == "output" and .active)) | .rect | "\(.x),\(.y) \(.width)x\(.height)"'
