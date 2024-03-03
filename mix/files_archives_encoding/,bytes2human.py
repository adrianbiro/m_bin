#!/usr/bin/python3
import sys


def _bytes2human(n: int) -> str:
    # http://code.activestate.com/recipes/578019
    symbols: tuple = ("K", "M", "G", "T", "P", "E", "Z", "Y")
    prefix: dict[str,int] = {}
    for i, s in enumerate(symbols):
        prefix[s] = 1 << (i + 1) * 10
    for s in reversed(symbols):
        if abs(n) >= prefix[s]:
            value = float(n) / prefix[s]
            return "%.1f%s" % (value, s)
    return "%sB" % n


def main() -> None:
    try:
        _bytes = sys.argv[1]
    except IndexError:
        _bytes = str(sys.stdin.read())

    try:
        print(_bytes2human(int(_bytes)))
    except ValueError as e:
        print(f"{e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    raise SystemExit(main())
