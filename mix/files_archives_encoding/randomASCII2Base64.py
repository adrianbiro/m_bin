#!/usr/bin/python3
import argparse
import random
import string
import base64

parser = argparse.ArgumentParser(
    description="Generate random ASCII string and base64 encode it."
)
parser.add_argument(
    "-n",
    "--num",
    type=int,
    nargs="?",
    default=20,
    help="Lenght of string, default is %(default)s.",
)

args = parser.parse_args()
_ascii = string.ascii_letters + string.punctuation
_string = "".join(random.choices(_ascii, k=args.num))  # nosec B311
_bytes = base64.b64encode(bytes(_string, "utf-8"))
print(str(_bytes, encoding="utf-8"))
