#!/usr/bin/python3
import argparse
import datetime
from datetime import datetime
import difflib
import os
from os import scandir
import shutil
import sys

parser = argparse.ArgumentParser()
command_group = parser.add_mutually_exclusive_group()
parser.add_argument('--about',
                     help='Print broader info about this program.',
                     action='store_true')
command_group.add_argument('--diff',
                    help='Show diff for two latest dbichf[date].txt files, to make it useful one needs at least two of them.',
                    action='store_true')
command_group.add_argument('--clear',
                    help='By invoking this option, one can remove all dbchf files and the .inschfiles directory.',
                    action='store_true')
command_group.add_argument('--scan',
                    help='This makes dbichf[date].txt file, its contains file path with a timestamp - the time of last modification.',
                    action='store_true')
args = parser.parse_args()

if len(sys.argv) == 1:
    parser.print_help()
    sys.exit(0)


def scantree(path):  # TODO exclude .inschfiles dir
    """This generates files for the get_db_file() function, starting from the current working directory, recursively."""
    for entry in scandir(path):
        if entry.is_dir(follow_symlinks=False):
            yield from scantree(entry.path)
        else:
            yield entry
def get_db_file():
    """It writes timestamps to the ~/dbichf file for every file."""
    filestree = []
    time_format = '%Y-%m-%d.%H:%M:%S'
    for entry in scantree('.'):
        time_stamp = os.stat(entry).st_mtime  # 1649245429.8756955
        form_time_stamp = f'{datetime.fromtimestamp(time_stamp):%Y-%m-%d.%H:%M:%S}'  # 2022-04-06.13:43:49
        filestree.append(entry.path + form_time_stamp)

    now = datetime.now()
    filename = f'{path_for_db}/dbichf{now.strftime(time_format)}.txt'
    with open(filename, "w") as f:
        for i in filestree:
            f.write(f'{i}\n')
    print(f'db created in {os.path.abspath(filename)}')


def get_diff():
    """This Prints classic diff output for changed files."""
    files = os.listdir(path_for_db)
    paths = [os.path.join(path_for_db, basename) for basename in files]
    fname1 = max(paths, key=os.path.getctime)
    paths.remove(fname1)
    fname2 = max(paths, key=os.path.getctime)
    with open(fname1) as of1:
        f1 = of1.readlines()
    with open(fname2) as of2:
        f2 = of2.readlines()
        for line in difflib.unified_diff(f1, f2, fromfile=fname1, tofile=fname2, lineterm=''):
                print(line)

def get_program_info():
    """This provides broader info about the program."""
    print("""
    The goal of this script is to track files
    that the newly installed program
    creates in the user's home directory.
    Or just to observe what files are changed
    by some actions. For this reason, the scan of
    the file system began from the current
    working directory and not from the fixed
    path of the user's home one.
    Output files are stored in ~/.inschfiles directory.
    """)

def main():
    global path_for_db  # There are calls for this one variable across other functions called below.
    path_for_db = os.path.expanduser('~')
    os.makedirs(f'{path_for_db}/.inschfiles', exist_ok=True)
    path_for_db = f'{path_for_db}/.inschfiles'

    if args.about:
        get_program_info()
    elif args.clear:
        if os.path.exists(path_for_db):  # FIXME For some reason, it still gives True even if there are no files.
            shutil.rmtree(path_for_db)
            print("Files removed.")
        else:
            print("There are no files to remove.")
    elif args.diff:
        num_of_files = len(os.listdir(path_for_db))
        if num_of_files >= 2:
            get_diff()
        else:
            print(f"There are not enough files to compare, run --scan first.\nNow you have {num_of_files} in {path_for_db}.")
    elif args.scan:
        get_db_file()
    else:
        sys.exit(0)
main()


