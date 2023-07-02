#!/bin/bash


_path="$(readlink -f "$(dirname "${0}")")"
# shellcheck disable=CS2016
printf "Run:\n\texport PATH=%s/bin:%s\n" "${_path}" '$PATH'
