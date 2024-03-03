#!/usr/bin/mksh
if [[ ${#} -eq 0 ]]; then
    echo -e "Usage:\n\t${0} <input_file> <output_file> <number_lines_to_shift>"
    exit 1
fi
infile=${1:?}
outfile=${2:?}
numlines=${3:?}

# add header
head -n 1 "${infile}" >>"${outfile}"
# skip header shift first N lines 2-n
sed -i -e 2,"${numlines}"$'{w/dev/stdout\n;d}' "${infile}" >>"${outfile}"

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
