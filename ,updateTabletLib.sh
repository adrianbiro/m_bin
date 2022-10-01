#!/bin/bash
# It is faster then calibre to move several gigs of data.

# run from target dir on terget device
SOURCE=${1:-~/adrian_knihy/Calibre Library}
if ! [[ -d "${SOURCE}" ]]; then
  echo -e "Usage:\v${0} <source dir>"
  exit 64
fi

#arr=$(ls)
#find "${SOURCE// /\ }" -type f \( -name '*.epub' -o -name '*.pdf' -o -name '*.djvu' \) -print0 | xargs -0r bash -c 'if ! [[ ${arr[*]} =~ "${0// /\ }" ]]; then cp ${0// \/ } . ; fi'

# Copy only when the SOURCE file is newer than the destination file
# or when the destination file is missing. Array lookup above is slower
# and error-prone due to multiple levels of shell invocation.

find "${SOURCE// /\ }" -type f \( -name '*.epub' -o -name '*.pdf' -o -name '*.djvu' \) -print0 | xargs -0r cp -u -t .


