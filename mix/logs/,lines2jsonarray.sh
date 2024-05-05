#!/bin/bash



jq -R -s 'split("\n") | .[:-1]' "${@}"

:<<'END_COMMENT'
$ cat file.txt
lkj.asd
qwe.wer
# split on new line, filter empty lines out
$ jq -R -s 'split("\n") | .[:-1]' file.txt
[
  "lkj.asd",
  "qwe.wer"
]
END_COMMENT