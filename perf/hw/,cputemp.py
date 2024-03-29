#!/usr/bin/python3
import argparse
from pathlib import Path
import re
from time import sleep


def temp_data(P: Path) -> list[tuple[str, str]]:
    def _getvalue(p: Path) -> str:
        with open(p, "r") as f:
            val: str = f.read()
        try:
            return f"{float(val) / 1000}°C"  # temp stores 54000 millidegree Celsius, that means 54°C
        except ValueError:  # type stores name
            val = val.rstrip()  # remove \n
            if (
                "acpitz" in val
            ):  # Escape sequence not allowed in expression portion of f-string
                return "{0}_{1}".format(
                    val, re.sub(r"\D", "", p.parts[-2])
                )  # thermal_zone[0-9]+ -> just digit)
        return val

    return sorted(
        [
            (_getvalue(i.joinpath("type")), _getvalue(i.joinpath("temp")))
            for i in (i for i in P.glob("thermal_zone*/"))
        ],
        key=lambda t: t[0].lower(),
    )  # sort list case-insensitive to prevent title case precedence


def format_table(P: Path) -> None:
    for k, v in (i for i in temp_data(P)):
        print(f"{f'{k}:':<20} {v}")


def main() -> None:
    parser = argparse.ArgumentParser(
        description=f"""
Show cpu temperature info from /sys/class/thermal/thermal_zone*/(temp|type).
\thttps://www.kernel.org/doc/Documentation/thermal/x86_pkg_temperature_thermal
\thttps://www.kernel.org/doc/Documentation/thermal/sysfs-api.txt""",
        formatter_class=argparse.RawTextHelpFormatter,
    )
    parser.add_argument(
        "-w",
        "--watch_interval",
        nargs="?",
        type=float,
        default=None,
        const=1,
        help="Watch temperature in '%(default)s' seconds intervals. Use 0.2 or .2 for fractions.",
    )
    args = parser.parse_args()

    P: Path = Path("/sys/class/thermal/")
    if inteval := args.watch_interval:
        while 1:
            try:
                format_table(P)
                sleep(inteval)
            except KeyboardInterrupt:
                exit(0)
    format_table(P)


if __name__ == "__main__":
    raise SystemExit(main())
