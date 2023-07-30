#!/usr/bin/python3
from operator import getitem
import psutil


def _ps() -> dict[str, dict[str, float]]:
    PSAUX = [
        # p.as_dict(attrs=["cpu_percent","username","memory_info","memory_percent","cpu_times",])
        {
            "username": p.username(),
            "cpu_percent": p.cpu_percent(
                interval=0
            ),  # interval=1 is blocking https://psutil.readthedocs.io/en/latest/#psutil.Process.cpu_percent
            "memory_info": p.memory_info(),
            "memory_percent": p.memory_percent(),
            "cpu_times": p.cpu_times(),
        }
        for p in psutil.process_iter()
    ]

    PRSTAT: dict[str, dict[str, float]] = {}
    for p in PSAUX:
        if not (_user := p["username"]) in PRSTAT:
            PRSTAT[_user] = {
                "NAME": _user,
                "COUNT": 0,
                "VSZ": 0,
                "RSS": 0,
                "MEMORY": 0,
                "TIME": 0,  # / 60 / 60 TODO time elapsed
                "CPU": 0,
            }
        PRSTAT[_user]["COUNT"] += 1
        PRSTAT[_user]["RSS"] += p["memory_info"].rss  # / 500 / 1024 / 1024  # to MB
        PRSTAT[_user]["VSZ"] += p["memory_info"].vms  # / 500 / 1024 / 1024  # to MB
        PRSTAT[_user]["CPU"] += p["cpu_percent"]
        PRSTAT[_user]["MEMORY"] += p["memory_percent"]  ## round .f2
        PRSTAT[_user]["TIME"] += p["cpu_times"].user + p["cpu_times"].system
    return PRSTAT


def _bytes2human(n: int) -> str:
    symbols: tuple = ("K", "M", "G", "T", "P", "E", "Z", "Y")
    prefix: dict[str, int] = {}
    for i, s in enumerate(symbols):
        prefix[s] = 1 << (i + 1) * 10
    for s in reversed(symbols):
        if abs(n) >= prefix[s]:
            value = float(n) / prefix[s]
            return "%.1f%s" % (value, s)
    return "%sB" % n


def ps_format(PRSTAT: dict[str, dict[str, float]]) -> None:
    for i in sorted(
        PRSTAT.items(), key=lambda x: getitem(x[1], "COUNT"), reverse=True
    ):  # list[tuple[str, dict[str, float]]]
        _user = i[1]
        print("{COUNT} {NAME} {VSZ} {RSS} {MEMORY} {TIME} {CPU}".format(**_user))


def main() -> None:
    ps_format(_ps())


if __name__ == "__main__":
    raise SystemExit(main())
