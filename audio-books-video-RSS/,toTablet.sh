#!/bin/bash
# It is faster then calibre to move several gigs of data.
# move all source arguments into current directory
find . -type f \( -name '*.epub' -o -name '*.pdf' -o -name '*.djvu' \) -print0 | xargs -0r mv -t .

