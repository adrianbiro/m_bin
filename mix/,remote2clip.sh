#!/bin/bash

# on remote
# mkfifo clip
# cat foo.log > clip

if [[ $(uname -o) =~ "Linux" ]]; then
    ssh "${1:-pplogss01}" cat clip | xclip -selection clipboard
else #git-bash on win
    ssh "${1:-pplogss01}" cat clip | clip
fi
