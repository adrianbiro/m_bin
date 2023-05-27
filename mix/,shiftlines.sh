#!/bin/bash
if [ ${#} -eq 0 ]; then printf "Usage:\n\t%s <input_file> <output_file> <number_lines_to_shift>\n" "${0##*/}"; exit 1; fi
infile=${1:?}
outfile=${2:?}
numlines=${3:?}

# add header
head -n 1 "${infile}" >>"${outfile}"
# skip header shift first N lines 2-n
# shellcheck disable=SC2086
sed -i -e 2,${numlines}$'{w/dev/stdout\n;d}' "${infile}" >>"${outfile}" ## todo in posix shell bash works Bashism $'..'

# shellcheck disable=SC2016,SC2034
doc=:'
ls -lt /app/csops/import/COLI.CSCOLL.SMAPP1.CI*
## COLI.CSCOLL.SMAPP1.CI230424.A001.PROC
## COLI.CSCOLL.SMAPP1.CI230424.A001.TODO
#####
## in pod
mkdir -p ~/bin; cat > ~/bin/,shiftlines.sh
## ctrl+d
chmod +x ~/bin/,shiftlines.sh
export PATH=$HOME/bin:$PATH
'
