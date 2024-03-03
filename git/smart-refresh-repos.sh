#!/bin/bash
find "${HOME}/src" -type d -name "smar*" -prune -print0 | while IFS= read -r -d '' repo; do cd "${repo}" || return; git pull --all --prune --no-tags; done
#https://github.com/google/codesearch
if command -v cindex 1>"/dev/null" 2>&1; then cindex "$(find "${HOME}/src" -type d -name "smar*" -prune -print)"; fi