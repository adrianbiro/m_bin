#!/usr/bin/python3
import requests
import os
import asyncio


def get_urls(headers: dict[str:str]) -> list[str]:
    """
    return list of files.<filename>.raw_ulr
    https://docs.github.com/en/rest/gists/gists?apiVersion=2022-11-28#list-gists-for-the-authenticated-user
    """
    urls: list[str] = list()

    _page: int = 1
    while True:
        url: str = "https://api.github.com/gists"
        params: dict[str:int] = dict(per_page=100, page=_page)
        res: requests.Response = requests.get(url=url, params=params, headers=headers)
        _urls: list[str] = [
            j["raw_url"] for i in res.json() for j in i["files"].values()
        ]
        if len(_urls) < 1:
            break
        urls.extend(_urls)
        _page += 1

    return urls


async def _fetch(url: str, headers: dict[str:str], location: str) -> None:
    res: requests.Response = requests.get(url=url, headers=headers)
    with open(name := os.path.join(location, url.split("/")[-1]), "w") as f:
        print(f"Fetching {name}")
        f.write(res.text)


async def get_files(urls: list[str], headers: dict[str:str], location: str) -> None:
    await asyncio.wait([await _fetch(url=url, headers=headers, location=location) for url in urls])


def main() -> None:
    if not (TOKEN := os.getenv("TOKEN")):
        print(f"Run:\n\tTOKEN=<token> {os.path.basename(__file__)}")
        exit(1)
    """location for files"""
    location: str
    os.makedirs(
        (location := os.path.join(os.environ["HOME"], "allgits", "Gists")),
        exist_ok=True,
    )
    headers: dict[str:str] = {
        "Accept": "application/vnd.github+json",
        "X-GitHub-Api-Version": "2022-11-28",
        "Authorization": f"Bearer {TOKEN}",
    }

    urls: list[str] = get_urls(headers=headers)
    
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    try:
        loop.run_until_complete(
            get_files(headers=headers, urls=urls, location=location)
        )
    except TypeError:
        ...
    finally:
        loop.close()


if __name__ == "__main__":
    raise SystemExit(main())
