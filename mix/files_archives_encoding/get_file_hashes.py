#!/usr/bin/env python3

import csv
import hashlib
from pathlib import Path

SCAN_PATH = "."
REPORT_PATH = "zmaz.csv"


def _sha256(f: Path) -> str:
    with open(f, "rb") as rf:
        return hashlib.file_digest(rf, "sha256").hexdigest()


def _bytes_to_human(b: int) -> str:
    _units = [
        (1 << 50, "PiB"),
        (1 << 40, "TiB"),
        (1 << 30, "GiB"),
        (1 << 20, "MiB"),
        (1 << 10, "KiB"),
        (1, "B"),
    ]
    for factor, suffix in _units:
        if b >= factor:
            break
    return f"{round(b / factor,ndigits=2)} {suffix}"


def main():
    files = [i for i in Path(SCAN_PATH).glob("**/*") if i.is_file()]
    report = [
        {
            "Name": f.name,
            "Path": str(f.absolute()),
            "SHA256": _sha256(f.absolute()),
            "Size_Bytes": f.stat().st_size,
            "Size_Human": _bytes_to_human(f.stat().st_size),
        }
        for f in files
    ]
    with open(REPORT_PATH, "w") as csv_report:
        writer = csv.DictWriter(
            csv_report,
            fieldnames=report[0].keys(),
            delimiter=",",
            lineterminator="\n",
        )
        writer.writeheader()
        writer.writerows(report)  # type: ignore


if __name__ == "__main__":
    raise SystemExit(main())
