#!/usr/bin/python3
import subprocess  # nosec B404
from operator import getitem
from datetime import timedelta


def sum_time(time: list[str]) -> timedelta:
    return sum(
        [
            timedelta(minutes=int(ms[1]), seconds=int(ms[2]))
            for t in time
            for ms in [t.split(":")]
        ],
        timedelta(),
    )


def _ps():
    PRSTAT: dict[str, dict[str, float]] = {}
    # fmt: off
    for i in subprocess.check_output(["ps", "aux"], encoding="utf-8").splitlines()[1:]: # nosec B603 B607
    # fmt: on
        _line = i.split()
        if not (_user := _line[0]) in PRSTAT:
            PRSTAT[_user] = {
                "NAME": _user,
                "COUNT": 0,
                "VSZ": 0,
                "RSS": 0,
                "MEM": 0,
                "TIME": "0:00",
                "CPU": 0,
            }
        PRSTAT[_user]["COUNT"] += 1
        PRSTAT[_user]["RSS"] += float(_line[5])
        PRSTAT[_user]["VSZ"] += float(_line[4])
        PRSTAT[_user]["CPU"] += float(_line[2])
        PRSTAT[_user]["MEM"] += float(_line[3])
        # PRSTAT[_user]["TIME"] = sum_time([PRSTAT[_user]["TIME"], _line[9]])

    return PRSTAT


def ps_format(PRSTAT: dict[str, dict[str, float]]) -> None:
    for i in sorted(
        PRSTAT.items(), key=lambda x: getitem(x[1], "COUNT"), reverse=True
    ):  # list[tuple[str, dict[str, float]]]
        _user = i[1]
        print("{COUNT} {NAME} {VSZ} {RSS} {MEM}% {TIME} {CPU}%".format(**_user))


def main() -> None:
    ps_format(_ps())


if __name__ == "__main__":
    raise SystemExit(main())
