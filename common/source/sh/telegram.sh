#!/bin/sh

exec flatpak run --env=QT_QPA_PLATFORM=wayland org.telegram.desktop
