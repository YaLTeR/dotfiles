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

output = None
if len(sys.argv) > 1:
    output = sys.argv[1]

workspaces = {}


def print_workspaces():
    vals = workspaces.values()
    if output is not None:
        vals = filter(lambda ws: ws["output"] == output, vals)

    vals = sorted(vals, key=lambda ws: ws["idx"])
    text = "\n".join(("󰪥" if ws["is_active"] else "󰄰" for ws in vals))
    print(json.dumps({"text": text}), flush=True)


for line in file:
    event = json.loads(line)

    if changed := event.get("WorkspacesChanged"):
        workspaces = {ws["id"]: ws for ws in changed["workspaces"]}
        print_workspaces()
    elif activated := event.get("WorkspaceActivated"):
        focused = activated["focused"]
        ws_output = workspaces[activated["id"]]["output"]
        for ws in workspaces.values():
            got_activated = ws["id"] == activated["id"]
            if ws["output"] == ws_output:
                ws["is_active"] = got_activated
            if focused:
                ws["is_focused"] = got_activated
        print_workspaces()
