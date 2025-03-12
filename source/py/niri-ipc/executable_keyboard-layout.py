#!/usr/bin/python3

import json
import os
import sys
from socket import AF_UNIX, SHUT_WR, socket

niri_socket = socket(AF_UNIX)
niri_socket.connect(os.environ["NIRI_SOCKET"])
file = niri_socket.makefile("rw")

file.write('"EventStream"')
file.flush()
niri_socket.shutdown(SHUT_WR)

names = []
current = None


def print_layout():
    if names[current].startswith("English"):
        text = ":)"
    elif names[current].startswith("Russian"):
        text = ":P"
    else:
        text = ":?"
    tooltip = names[current]
    print(json.dumps({"text": text, "tooltip": tooltip}), flush=True)


for line in file:
    event = json.loads(line)

    if changed := event.get("KeyboardLayoutsChanged"):
        layouts = changed["keyboard_layouts"]
        names = layouts["names"]
        current = layouts["current_idx"]
        print_layout()
    elif switched := event.get("KeyboardLayoutSwitched"):
        current = switched["idx"]
        print_layout()
