#!/bin/sh

if command -v readlink 1>"/dev/null" 2>&1; then
    _path="$(readlink -f $(dirname "${0}"))"
else
    _path="$(cd $(dirname "${0}") >"/dev/null" && pwd)" # the cd will not write output if it lands in ~/
fi
# shellcheck disable=CS2016
printf "Run:\n\texport PATH=%s/bin:\$PATH\n" "${_path}"
