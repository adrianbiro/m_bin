import subprocess
import sys

#https://www.youtube.com/watch?v=f0zD9d7kBrU
subprocess.check_call(["ls", "-l"], stdout=sys.stdout, stderr=sys.stderr)
