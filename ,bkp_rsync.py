#!/usr/bin/python3
import os
import glob
import subprocess


LOCATION = "/mnt/mydisk"
def run_rsync():
    """Wrapper for the rsync, with intentionally hardcoded paths. Since the shutil functions cannot copy all file metadata, this is a better and even faster solution."""
    subprocess.call(["rsync",
                    "-rauvlPL",
                    "--progress",
                    "--delete",
                    "/home/adrian/adrian_knihy",
                    "/home/adrian/gits",
                    "/home/adrian/Applications",
                    "/mnt/mydisk/"])  # / on end is intentional.

def test_path():
    """Check if the device is mounted on the expected mount point, if it is automounted in the default position prompt the user to  remount it. Since various desktop environments use to try to automount even devices that have noauto option in /etc/fstab, it's less hassle to put a little test here, then is to resolve it again and again."""
    if os.path.ismount(LOCATION):
        run_rsync()
    else:
        device = "".join(glob.glob("/media/adrian/*"))
        msg= f"Mount it in to {LOCATION}"
        if os.path.ismount(device):
            print(f"Unmount {device}\n{msg}")
        else:
            print(msg)

def main():
    """Check if it is run with elevated privileges."""
    if os.getuid() == 0:
        test_path()
    else:
        print("Run with sudo!")

if __name__ == "__main__":
    main()
