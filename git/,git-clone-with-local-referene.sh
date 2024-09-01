#!/bin/bash

[[ "${#@}" -lt 2 ]] && {
    printf "Usage:\n\t%s </path/to/local/referece> <remote/origin/url> [new name]\n", "${0##*/}"
    exit 1
}
git clone --dissociate --reference "${@}"

# https://git-scm.com/docs/git-clone/en#Documentation/git-clone.txt-code--dissociatecode
# https://git-scm.com/docs/git-clone/en#Documentation/git-clone.txt-code--referencecodecode-if-ablecodeemltrepositorygtem
