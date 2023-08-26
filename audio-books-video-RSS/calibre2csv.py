#!/usr/bin/python3
from json import load
from pathlib import Path, PurePath
import csv
import sys
from signal import signal, SIGPIPE, SIG_DFL

signal(SIGPIPE, SIG_DFL)  # fix BrokenPipeError

LOCATION: PurePath = PurePath(Path.home(), "adrian_knihy", "Calibre Library")

#TODO metadata.db
def get_book_list(location: PurePath) -> list[dict[str, str]]:
    _path: PurePath = PurePath(location, ".metadata.calibre")
    with open(_path) as f:
        data = load(f)
    return [
        {
            "authors": "; ".join(sorted(i["authors"])),
            "title": i["title"],
            "path": str(PurePath(location, i["lpath"])),
        }
        for i in data
    ]


def write_csv_to_stdin(lib: list[dict[str, str]]) -> None:
    output_file = csv.DictWriter(
        sys.stdout, fieldnames=lib[0].keys(), delimiter=",", quoting=1
    )
    output_file.writeheader()
    output_file.writerows(lib)

if __name__ == "__main__":
    lib: list[dict[str, str]] = sorted(
        get_book_list(location=LOCATION), key=lambda k: (k["authors"], k["title"])
    )

    write_csv_to_stdin(lib=lib)