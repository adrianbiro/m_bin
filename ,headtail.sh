#!/bin/bash

{ [[ $# -eq 0 ]] && test -t 0; } && {
    printf 'Usage:\n\t%s' "${0##*/} [{head|tail} options] <file> " 1>&2
    exit 1
}

allLines="$(cat /dev/stdin)"
{
    head "${@}" <<<"${allLines}"
    # shellcheck disable=SC2183
    printf '%*s\n' "$(tput cols)" | tr ' ' '.'
    tail "${@}" <<<"${allLines}"
}

: <<'END_COMMENT'
Run tail and head same time with dotted line as separator
seq 10 | ./,headtail.sh -n 2
1
2
.......................
9
10
END_COMMENT
