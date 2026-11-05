#!/usr/bin/env python3
"""Focus a Space by its one-based list position, or select the last Space."""

import json
import os
import subprocess
import sys


def main():
    if len(sys.argv) != 2:
        raise ValueError("usage: focus-space.py <space-number|last>")
    if sys.argv[1] == "last":
        index = -1
    else:
        position = int(sys.argv[1])
        if position < 1:
            raise ValueError("space-number must be positive")
        index = position - 1
    if not os.environ.get("HERDR_SOCKET_PATH"):
        raise ValueError("run this command through a Herdr keybinding")

    binary = os.environ.get("HERDR_BIN_PATH") or "herdr"
    response = subprocess.run(
        [binary, "workspace", "list"],
        check=True,
        capture_output=True,
        text=True,
        timeout=5,
    )
    workspaces = json.loads(response.stdout)["result"]["workspaces"]
    if not workspaces or index >= len(workspaces):
        return

    workspace_id = workspaces[index]["workspace_id"]
    subprocess.run(
        [binary, "workspace", "focus", workspace_id],
        check=True,
        stdout=subprocess.DEVNULL,
        timeout=5,
    )


if __name__ == "__main__":
    try:
        main()
    except (ValueError, KeyError, OSError, subprocess.SubprocessError) as error:
        print(f"focus-space: {error}", file=sys.stderr)
        sys.exit(1)
