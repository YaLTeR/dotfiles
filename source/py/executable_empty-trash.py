#!/usr/bin/env python3
import argparse
import shutil
import sys
from datetime import datetime, timedelta
from pathlib import Path


def remove(path: Path) -> None:
    try:
        if path.is_dir() and not path.is_symlink():
            shutil.rmtree(path)
        else:
            path.unlink()
    except FileNotFoundError:
        pass
    except Exception as e:
        print(f"warning: could not remove {path}: {e}", file=sys.stderr)


def deletion_date(info: Path):
    try:
        for line in info.read_text(errors="replace").splitlines():
            if line.startswith("DeletionDate="):
                return datetime.strptime(line.split("=", 1)[1], "%Y-%m-%dT%H:%M:%S")
    except Exception as e:
        print(f"warning: could not read/parse {info}: {e}", file=sys.stderr)
    return None


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("-f", action="store_true", help="actually delete; without this, only print a dry run")
    parser.add_argument("days", type=int, nargs="?", default=7)
    args = parser.parse_args()

    # In the future, might extend to other mounts with their .Trash folders
    trash = Path.home() / ".local/share/Trash"
    info_dir = trash / "info"
    files_dir = trash / "files"
    cutoff = datetime.now() - timedelta(days=args.days)

    to_delete = []

    if info_dir.is_dir():
        for info in info_dir.glob("*.trashinfo"):
            d = deletion_date(info)
            if d is not None and d < cutoff:
                to_delete.append(files_dir / info.stem)
                to_delete.append(info)

    # Orphans: files without matching .trashinfo
    if files_dir.is_dir():
        for f in files_dir.iterdir():
            if not (info_dir / f"{f.name}.trashinfo").exists():
                to_delete.append(f)

    if not args.f:
        if to_delete:
            for path in sorted(to_delete):
                print(path)
            print("\nDRY RUN. Pass -f to actually delete.")
        else:
            print("DRY RUN. Nothing to delete.")
        return

    for path in to_delete:
        remove(path)


if __name__ == "__main__":
    main()
