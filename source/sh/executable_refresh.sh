#!/bin/sh

usage() {
    echo "Usage: $0 <auto|120>"
    exit 1
}

if [ $# -eq 0 ]; then
    usage
fi

case $1 in
    auto)
        # niri msg output "Acer Technologies XV320QU LV 420615FCD4200" mode auto
        niri msg output "LG Electronics LG ULTRAWIDE 511NTKFCK997" mode auto
        ;;
    120)
        # niri msg output "Acer Technologies XV320QU LV 420615FCD4200" mode "2560x1440@119.998"
        niri msg output "LG Electronics LG ULTRAWIDE 511NTKFCK997" mode "3840x1600@120.043"
        ;;
    *)
        usage
        ;;
esac
