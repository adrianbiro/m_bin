#!/usr/bin/env python3
"""Get subset of lines from jsonl files"""
import argparse
import linecache
import mmap
import random
import sys


class SubsetLines:
    def __init__(
        self,
        file: str,
        mode: str,
        lines: int,
        percent: int | None = None,
        seed: int | None = None,
        flush: bool = False,
        encoding: str = "utf-8",
    ):
        modes: set[str] = {"start", "end", "random"}
        self.infile = file
        self.percent = percent
        self.lines = lines
        self.seed = seed
        self.flush = flush
        self.encoding = encoding
        if mode not in modes:
            raise ValueError(f"Invalid mode: {mode}, valid modes are {modes}")
        self.mode = mode
        if self.percent or self.mode in {"end", "random"}:
            self.lines_count = self.__get_file_lines()
        if self.percent:
            self.lines = (self.lines_count * self.percent) // 100
            if self.lines <= 0:
                raise ValueError(
                    f"Value of PERCENT: {self.percent} is to small. For file length: {self.lines_count}"
                )
        linecache.lazycache(filename=self.infile, module_globals=globals())

    def __get_file_lines(self):
        """TODO faster way? line_count = sum((1 for _ in open(self.infile, "rb")))"""
        with open(
            file=self.infile,
            encoding=self.encoding,
            mode="r+",
        ) as f:
            buf = mmap.mmap(f.fileno(), 0)
            lines = 0
            readline = buf.readline
            while readline():
                lines += 1
            return lines

    def get_lines(self):
        """add 1 to ranges since linecache.getline(self.infile,0) returns empty string"""
        _range = range(1, self.lines + 1)  # start
        if self.mode == "end":
            _range = range(self.lines_count+1)[-self.lines:]
        elif self.mode == "random":
            if self.seed:
                random.seed(self.seed)
            _range = random.sample(range(1, self.lines_count + 1), self.lines)

        for idx in _range:
            print(linecache.getline(self.infile, idx), end="", flush=self.flush)


def main():
    parser = argparse.ArgumentParser(description="Get subset of lines.")
    parser.add_argument("-f", "--file", required=True, help="Input file.", type=str)
    parser.add_argument("-l", "--lines", type=int, default=4, help="Default: '%(default)s'")
    parser.add_argument(
        "-m",
        "--mode",
        choices={"start", "end", "random"},
        default="start",
        help="Default: '%(default)s'",
        type=str,
    )
    parser.add_argument("-p", "--percent", type=int, help="Percent of lines.")
    parser.add_argument(
        "-s", "--seed", type=int, help="Fixed seed for random generation."
    )
    parser.add_argument(
        "--encoding",
        default="utf-8",
        help="Default: '%(default)s'",
        type=str,
    )
    parser.add_argument(
        "--flush",
        action="store_true",
        default=False,
        help="Flush lines, buffering default: '%(default)s'",
    )

    try:
        args = parser.parse_args()
        sl = SubsetLines(**vars(args))
        sl.get_lines()
    except (ValueError, FileNotFoundError) as e:
        print(e, file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    raise SystemExit(main())