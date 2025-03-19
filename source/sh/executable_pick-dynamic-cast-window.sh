#!/bin/sh

exec niri msg action set-dynamic-cast-window --id="$(niri msg --json pick-window | jq .id)"
