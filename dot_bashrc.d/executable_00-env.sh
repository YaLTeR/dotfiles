#!/usr/bin/bash

prepend_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="$1${PATH:+:$PATH}"
    esac
}

prepend_path "$HOME/.cargo/bin"
prepend_path "$HOME/.local/bin"
export PATH

export CPM_SOURCE_CACHE=$HOME/.cache/cpm
export EDITOR=e
export VISUAL=e
