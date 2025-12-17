#!/usr/bin/env python3
"""Toolbox command server - listens on Unix socket, spawns detached processes."""

import asyncio
import os
import subprocess
from pathlib import Path

SOCKET_PATH = Path(os.environ["XDG_RUNTIME_DIR"]) / "tbx.sock"


async def handle_client(reader: asyncio.StreamReader, writer: asyncio.StreamWriter):
    try:
        data = await reader.read(65536)
        if not data.endswith(b"\0\0"):
            return
        args = data.split(b"\0")[:-2]
        if args:
            subprocess.Popen(
                [arg.decode() for arg in args],
                start_new_session=True,
                stdin=subprocess.DEVNULL,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )
    except Exception as e:
        print(f"Error: {e}")
    finally:
        writer.close()
        await writer.wait_closed()


async def main():
    SOCKET_PATH.unlink(missing_ok=True)
    server = await asyncio.start_unix_server(handle_client, path=SOCKET_PATH)
    os.chmod(SOCKET_PATH, 0o600)
    print(f"Listening on {SOCKET_PATH}")
    async with server:
        await server.serve_forever()


if __name__ == "__main__":
    asyncio.run(main())
