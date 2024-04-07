#!/bin/sh

usage() {
    echo "Usage: $0 <144|120>"
    exit 1
}

if [ $# -eq 0 ]; then
    usage
fi

case $1 in
    144)
        sed 's/^\(\s\+\)\/\/ \(mode "2560x1440@143.912"\)/\1\2/;s/^\(\s\+\)\(mode "2560x1440@119.998"\)/\1\/\/ \2/' -i --follow-symlinks ~/.config/niri/config.kdl
        ;;
    120)
        sed 's/^\(\s\+\)\(mode "2560x1440@143.912"\)/\1\/\/ \2/;s/^\(\s\+\)\/\/ \(mode "2560x1440@119.998"\)/\1\2/' -i --follow-symlinks ~/.config/niri/config.kdl
        ;;
    *)
        usage
        ;;
esac
