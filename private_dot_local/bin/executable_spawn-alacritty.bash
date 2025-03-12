#!/bin/bash

main() {
    local target
    if [[ "$1" == "toolbox" ]]; then
        target="toolbox"
    elif [[ "$1" == "host" ]]; then
        target="host"
    else
        echo "Provide target: host or toolbox"
        exit 1
    fi

    local display="${WAYLAND_DISPLAY:-${DISPLAY:-}}"
    display="${display//\//-}"
    local socket="$XDG_RUNTIME_DIR/Alacritty-$target-$display.sock"

    if [[ "$2" == "--daemon" ]]; then
        rm "$socket"
        if [[ "$target" == "toolbox" ]]; then
            exec t alacritty --socket="$socket" --daemon
        else
            exec alacritty --socket="$socket" --daemon
        fi
    fi

    if ! alacritty msg --socket="$socket" create-window --working-directory="$PWD"; then
        if [[ "$target" == "toolbox" ]]; then
            exec t alacritty --socket="$socket"
        else
            exec alacritty --socket="$socket"
        fi
    fi
}

main "$@"
