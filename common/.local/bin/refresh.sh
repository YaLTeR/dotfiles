#!/bin/sh

usage() {
    echo "Usage: $0 <170|120>"
    exit 1
}

if [ $# -eq 0 ]; then
    usage
fi

case $1 in
    170)
        niri msg output DP-2 mode '2560x1440@170.071'
        ;;
    120)
        niri msg output DP-2 mode '2560x1440@119.998'
        ;;
    *)
        usage
        ;;
esac
