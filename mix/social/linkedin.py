#!/usr/bin/env python3
import argparse
import urllib.parse
from collections import namedtuple


def _args():
    parser = argparse.ArgumentParser(description="Construct LinkedIn Search URL.")
    parser.add_argument(
        "-f",
        "--first",
        type=str,
        required=True,
        help="First Name",
    )
    parser.add_argument(
        "-l",
        "--last",
        required=True,
        type=str,
        help="Last Name",
    )
    return parser.parse_args()


def main():
    args = _args()

    Components = namedtuple(
        typename="Components",
        field_names=["scheme", "netloc", "url", "path", "query", "fragment"],
    )
    params = {"first": args.first, "last": args.last, "search": "Search"}
    url = urllib.parse.urlunparse(
        Components(
            scheme="https",
            netloc="linkedin.com/pub/dir",
            query=urllib.parse.urlencode(params),
            path="",  # path="/pub/dir", TODO will return url with semicolon, why?
            url="/",
            fragment="",
        )
    )
    print(url)
    # "https://www.linkedin.com/pub/dir/?first=%s&last=%s&search=Search"


if __name__ == "__main__":
    main()
