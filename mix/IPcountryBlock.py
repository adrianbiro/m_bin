#!/usr/bin/python3
from pathlib import Path
from collections import defaultdict
import csv
from ipaddress import ip_address, IPv4Address, IPv6Address

v4COUNTRY: defaultdict[str, list[IPv4Address]] = defaultdict(list)
v6COUNTRY: defaultdict[str, list[IPv6Address]] = defaultdict(list)


def write_file(country: str, ips: list[IPv4Address | IPv6Address], path: Path) -> None:
    for i in ips: #TODO
        print(country, str(i))


def read_file(file: Path):
    with open(file, "r") as f:
        csvf = csv.reader(f, delimiter="|")
        for line in csvf:
            try:
                if isinstance(_ip := ip_address(line[3]), IPv4Address):
                    v4COUNTRY[line[1]].append(_ip)
                if isinstance(_ip := ip_address(line[3]), IPv6Address):
                    v6COUNTRY[line[1]].append(_ip)
            except (ValueError, IndexError):
                pass


def main() -> None:
    P = Path("/home/adrian/Downloads/ip")
    for f in P.glob("delegated-*-latest.txt"):
        read_file(f)
    for c, ips in v4COUNTRY.items():
        write_file(ips=ips, path=P, country=f"{c}_IPv4.txt")
    for c, ips in v6COUNTRY.items():
        write_file(ips=ips, path=P, country=f"{c}_IPv6.txt")


if __name__ == "__main__":
    main()
