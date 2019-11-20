#!/bin/sh
swaymsg -t get_tree | jq 'recurse(.nodes[]?, .floating_nodes[]?) | select(.focused)'
