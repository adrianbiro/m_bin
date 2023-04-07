#!/usr/bin/python3
import re
import argparse
import sys

parser = argparse.ArgumentParser(
    description="Read log file and print out entire log entries that contain the specified error string."
)
parser.add_argument(
    "file",
    type=str,
    nargs="?",
    default=sys.stdin,
    help="log file to read, reads from stdin if not provided",
)
parser.add_argument(
    "-e",
    "--error-pattern",
    type=str,
    default=r"java.lang.NullPointerException",
    help="error string, default is 'java.lang.NullPointerException'",
)
args = parser.parse_args()
timestamp_pattern = r"^[0-3]?[0-9].[0-3]?[0-9].(?:[0-9]{2})?[0-9]{2}.*$"
error_pattern = args.error_pattern


def parse_log(f):
    log_entry = ""
    for i in f:
        if re.search(timestamp_pattern, i):
            if re.search(error_pattern, log_entry):
                print(log_entry)
            log_entry = i
            continue
        log_entry += i


def main():
    if args.file == sys.stdin:
        # there is nothing on stdin
        if sys.stdin.isatty():
            return parser.print_help()
        return parse_log(sys.stdin)
    with open(args.file, "r") as f:
        return parse_log(f)


if __name__ == "__main__":
    sys.exit(main())
