#!/bin/bash
# deploy man page to man path
file="${1:? Usage: ${0##*/} <man_file>.1}"
if [[ "${file##*.}" -ne 1 || "${file##*.}" == ".groff" ]]; then
    echo "name of man file must be in form file.1 not ${file}"
    exit 1
fi
gzip -c "${file}" >"/usr/local/man/man1/${file}.gz"
