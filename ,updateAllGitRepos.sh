#!/bin/bash

find "${HOME}/allgits" -mindepth 1 -maxdepth 1 -type d -print0 | while IFS= read -r -d '' repo; do
    cd "${repo}" || return
    git fetch --all --update-head-ok  # https://stackoverflow.com/a/19205680/18172103
    git pull origin "$(git branch | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')" # TODO all branches
done 

# https://stackoverflow.com/a/10312587/18172103
#git branch -r | grep -v '\->' | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | while read remote; do git branch --track "${remote#origin/}" "$remote"; done