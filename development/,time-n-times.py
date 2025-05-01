#!/usr/bin/env python3
"""
Time command execution N times in row to get best, average, and worsk value.
To pass multiple arguments use double dashes:
    time-n-times -n 10 -- ls -l
"""
import argparse
import os
import subprocess
import time


def main(): # pylint: disable=C0116
    parser = argparse.ArgumentParser(description="time-n-times -n 10 -- ls -l")
    parser.add_argument("-n", type=int, default=5)
    parser.add_argument("cmd", nargs="+")
    args = parser.parse_args()

    runs: list[int] = []
    with open(os.devnull, "w", encoding="utf-8") as devnull:
        for _ in range(args.n):
            start = time.perf_counter_ns()
            subprocess.call(args.cmd, stdout=devnull)
            end = time.perf_counter_ns()
            runs.append(end - start)
            print(".", end="", flush=True)
    print(
        f"""
Min of {args.n} runs:\t{(min(runs)/1e9):.3f}s
Avg of {args.n} runs:\t{(sum(runs)/float(len(runs))/1e9):.3f}s
Max of {args.n} runs:\t{(max(runs)/1e9):.3f}s
"""
    )  # 1e9 nanoseconds to seconds


if __name__ == "__main__":
    raise SystemExit(main())
