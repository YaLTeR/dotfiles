#!/bin/sh

# Can't set PATH in ~/.config/environment.d/ for some reason.
export PATH=$HOME/.cargo/bin:$PATH

exec sway "$@"
