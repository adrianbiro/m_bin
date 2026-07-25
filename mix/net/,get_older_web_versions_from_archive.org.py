"""
python3 ,get_older_web_versions_from_archive.org.py > urls.txt
"""

import os
import sys

import requests

try:
    TIMEOUT = os.environ["TIMEOUT"]
except KeyError:
    TIMEOUT = 10

try:
    DOMAIN = os.environ["URL_TO_MATCH"]  
except KeyError:
    print(
        f"Usage:\n\tURL_TO_MATCH=<URL_OR_DOMAIN> {sys.argv[0]} > urls.txt",
        file=sys.stderr,
    )
    sys.exit(1)


def get_old_urls(domain: str) -> list[str] | None:
    def print_to_stderr(msg):
        print(msg, file=sys.stderr)

    """
    https://github.com/internetarchive/wayback/tree/master/wayback-cdx-server#basic-usage

    https://web.archive.org/cdx/search/cdx?url=https://api.rtvs.sk/xml/podcast_archive.xml?series=1346*&output=json&limit=100
    [["urlkey","timestamp","original","mimetype","statuscode","digest","length"],
    ["sk,rtvs,api)/xml/podcast_archive.xml?series=1346","20170630234511","http://api.rtvs.sk:80/xml/podcast_archive.xml?series=1346","text/xml","200","M272JKODTXVDKISYNI3DBRKA2GLH2NHO","4787"],

     https://web.archive.org/web/20170630234511/https://api.rtvs.sk/xml/podcast_archive.xml?series=1346
    """

    urls: list[str] = []
    try:
        with requests.get(
            url="http://web.archive.org/cdx/search/cdx",
            timeout=TIMEOUT,
            params={"url": f"{domain}", "output": "json", "showNumPages": "true"},
        ) as resp:
            total_pages = int(resp.json()[1][0])  # [["numpages"],["2796"]]
        print_to_stderr(f"{total_pages=}")
    except Exception as e:
        print_to_stderr(e)
        return

    current_page = 0
    while total_pages >= current_page:
        try:
            print_to_stderr(f"{current_page=}")
            with requests.get(
                url="http://web.archive.org/cdx/search/cdx",
                timeout=TIMEOUT,
                params={
                    "url": f"{domain}",
                    "output": "json",
                    "pageSize": 100,
                    "page": current_page,
                    "filter": "statuscode:200",
                    "matchType": "exact",
                },
            ) as resp:
                print_to_stderr(f"{resp.url}")
                urls.extend(
                    f"https://web.archive.org/web/{i[1]}/{i[2]}"
                    for i in resp.json()[1:]
                )
        except KeyboardInterrupt:
            print_to_stderr("Returning at least some results")
            return urls
        except Exception as e:
            print_to_stderr(e)
        current_page += 1

    return urls


def main():
    if urls := get_old_urls(DOMAIN):
        for i in urls:
            print(i)


if __name__ == "__main__":
    raise SystemExit(main())
