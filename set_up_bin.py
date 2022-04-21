#!/usr/bin/python3
import os

targetdir = os.path.join(os.path.expanduser("~"), "bin")
os.makedirs(targetdir, exist_ok=True)
renamed = []
for i in os.listdir():
    if i.startswith((".git", ".gitignore", "README.md", "set_up_bin.py")) or i.endswith((".swp", ".md")):
        continue
    src = os.path.abspath(i)
    dest = os.path.join(targetdir, i)
    if os.path.islink(dest):
        continue
    if os.path.isfile(dest) or os.path.isdir(dest):
        new_name = f'{dest}.bak'
        os.rename(dest, new_name)
        renamed.append(f'{dest} --> {new_name}')
    os.symlink(src, dest)
    print(f'Symlink created\n{src} --> {dest}')



if len(renamed) > 0:
    print("Backup files:")
    for i in renamed:
        print(i)
