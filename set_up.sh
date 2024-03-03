#!/bin/bash

BINDIR="${HOME}/bin"
BIN_REPO="m_bin"

if [[ "${PWD##*/}" != "${BIN_REPO}" ]]; then
    echo "Run from ${BIN_REPO} directory."
    exit 1
fi

rm -rf "${BINDIR}" 1>"/dev/null" 2>&1
mkdir -p "${BINDIR}" 1>"/dev/null" 2>&1


find "${PWD}" -maxdepth 1 -type f -name ",*" -print0 | while IFS= read -r -d '' file; do
    ln -sf "${file}" "${BINDIR}/${file##*/}"
done
