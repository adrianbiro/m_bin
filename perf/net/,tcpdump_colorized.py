#!/usr/bin/env python3
import re
import sys
from types import SimpleNamespace

COLORS = SimpleNamespace(
    CLEAR="\033[0m",
    RED="\033[31m",
    GREEN="\033[32m",
    YELLOW="\033[33m",
    BLUE="\033[34m",
    PURPLE="\033[35m",
    CYAN="\033[36m",
)

RG = SimpleNamespace(
    timestamp_and_protocol=re.compile(
        r"^((?:[\d\-]+\s)?[\d:\.]+ )?([A-Z0-9]{2,}(?: \d+\.[\da-z]+(?=,))?)([ ,].*)"
    ),
    ipv6=re.compile(
        r"(?P<ipv6>(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])))"
    ),
    ipv4=re.compile(
        r"(?P<ipv4>((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))"
    ),
    fqdn=re.compile(r"(?P<fqdn>(?:[A-Za-z\d\-\.]+\.[a-z]+))"),
    packet_data=re.compile(r"(?P<packet_data>(^\s+0x[0-9a-f]+(?=:)))"),
    warnings=re.compile(r"(?P<warnings>(\[bad udp cksum[^\]]*\]))"),
    # replace with named capture groups
    ipv6_color=r"%s\g<ipv6>%s" % (COLORS.CYAN, COLORS.CLEAR),
    ipv4_color=r"%s\g<ipv4>%s" % (COLORS.BLUE, COLORS.CLEAR),
    fqdn_color=r"%s\g<fqdn>%s" % (COLORS.GREEN, COLORS.CLEAR),
    packet_data_color=r"%s\g<packet_data>%s" % (COLORS.PURPLE, COLORS.CLEAR),
    warnings_color=r"%s\g<warnings>%s" % (COLORS.RED, COLORS.CLEAR),
)


def colorize(line):
    out_line = []
    match = re.match(RG.timestamp_and_protocol, line)
    if match:
        timestamp, protocol, rest = match.groups()
        if timestamp:
            out_line.append(
                f"{COLORS.GREEN}{timestamp}{COLORS.CLEAR}",
            )
        out_line.append(f"{COLORS.YELLOW}{protocol}{COLORS.CLEAR}")
        ##
        line = rest
    line = re.sub(RG.ipv6, RG.ipv6_color, line)
    line = re.sub(RG.ipv4, RG.ipv4_color, line)
    line = re.sub(RG.fqdn, RG.fqdn_color, line)
    line = re.sub(RG.packet_data, RG.packet_data_color, line).replace(
        "\n", ""
    )  # TODO somehow new line will be addted, so remove it
    line = re.sub(RG.warnings, RG.warnings_color, line)  # TODO find data

    out_line.append(line)
    return "".join(out_line)


def main():
    # there is nothing on stdin
    if sys.stdin.isatty():
        print(
            f"Usage:\n\ttcpdump -r file.pcap | {sys.argv[0]} | less -R", file=sys.stderr
        )
        sys.exit(1)

    try:
        for line in sys.stdin:
            print(colorize(line))
            sys.stdout.flush()
    except (KeyboardInterrupt, BrokenPipeError):
        sys.stderr.close()
        sys.exit()


if __name__ == "__main__":
    raise SystemExit(main())
