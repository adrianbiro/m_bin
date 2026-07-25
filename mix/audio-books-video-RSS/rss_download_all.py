"""Download rss feed"""
import xml.etree.ElementTree as ET
from pathlib import Path

import requests

#https://api.rtvs.sk/xml/podcast_archive.xml?series=1346s
RSS_FILE = 'zmaz/parnas.xml'
DOWNLOAD_PATH = 'zmaz/audio_files'


tree = ET.parse(Path(RSS_FILE).absolute())
root = tree.getroot()

links: dict[str,str] = {}

for i in root.iter('item'):
    links[i.find('description').text] = i.find('link').text # type: ignore

for k,v in links.items():
    # sanitaze name, and make is shorter to avoid 'File name too long' error
    k = k.replace('/','-').replace('\\','-')[:200]
    _file = Path(DOWNLOAD_PATH).joinpath(k)
    if _file.exists():
        print(f"Skipping:\t{_file}", flush=True)
        continue
    print(f"Downloading:\t{k}\nfrom:\t{v}", flush=True)
    with requests.get(v, timeout=5, verify=False) as req, open(_file, "wb") as f:
            f.write(req.content)

