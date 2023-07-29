#!/usr/bin/python3

import psutil
from collections import namedtuple
from collections import defaultdict


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


PSAUX = [
    proc.as_dict(
        attrs=[
            "cpu_percent",
            "username",
            "memory_info",
            "memory_percent",
            "cpu_times",
        ]
    )
    for proc in psutil.process_iter()
]

PRSTAT: dict[str, dict[str, float]] = {}  #dit to tuple
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
    PRSTAT[_user]["CPU"] += p["cpu_percent"] ## round .f2
    PRSTAT[_user]["MEMORY"] += p["memory_percent"]
    PRSTAT[_user]["TIME"] += sum(p["cpu_times"]) ## zle fur nula
print(PRSTAT["adrian"])
# arg json, raw, with conv, dict 2 tuple 