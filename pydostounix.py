#!/usr/bin/python3
import os
from os import scandir

def scantree(path):
    """Generate files from current working directory."""
    for entry in scandir(path):
        if entry.is_dir(follow_symlinks=False):
            yield from scantree(entry.path)
        else:
            yield entry


def sort_files():
    """Produces a list of files sorted out of compressed formats."""
    file_list = []
    for i in scantree("."):
        if i.name.endswith((".jpg",
                       ".jpeg",
                       ".png",
                       ".zip",
                       ".rar",
                       ".gzip",
                       ".xz",
                       ".7z",
                       ".bz2",
                       ".tar",
                       ".bzip2")):
            continue
        file_list.append(os.path.abspath(i))
    return file_list

"""Replace DOS newline character with UNIX one, and modify just ASCII-compatible parts of encodings."""
for i in sort_files():
    ilist = i.split("/")
    if ".git" in ilist:
        continue
    with open(i, 'r', encoding="ascii", errors="surrogateescape") as f:
        text = f.read().replace('\r\n', '\n')
    with open(i, 'w', encoding='utf-8', errors="surrogateescape") as nf:
        nf.write(text)










