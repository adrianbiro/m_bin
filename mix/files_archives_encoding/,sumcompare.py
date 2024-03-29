#!/usr/bin/python3
import argparse
import hashlib
import mmap
import pyperclip

parser = argparse.ArgumentParser()
parser.add_argument('file_name',
                    help='Copy sum for comparing to clipboard, and specify the file name as an argument.',
                    type=str)
parser.add_argument('-md5',
                    '--md5sum',
                    help='for md5sum',
                    action='store_true')
args = parser.parse_args()

file_name = args.file_name
sum_to_compare = str(pyperclip.paste())
try:
    if int(sum_to_compare, 16):  # Check by conversion if it is valid hexadecimal (base 16).
        with open(file_name, "rb") as f:
            with mmap.mmap(f.fileno(), length=0, prot=mmap.PROT_READ) as mm:
                bytes = mm.read()
                if args.md5sum:
                    testsum = hashlib.md5(bytes).hexdigest()
                else:
                    testsum = hashlib.sha256(bytes).hexdigest()

        if testsum == sum_to_compare:
            print("The file is correct")
        else:
            print("Sums differ, chceck it")

        print(f'{sum_to_compare}\tsum.')
        print(f'{testsum}\tsum from the clipboard.')
except ValueError:
    print(f"The string in the clipboard isn't valid hexadecimal:\n{sum_to_compare}")
