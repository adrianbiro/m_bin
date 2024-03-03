#!/bin/bash

tail -f "${@:1}" |
  sed -e 's/\(.*INFO.*\)/\x1B[32m\1\x1B[39m/' \
    -e 's/\(.*WARNING.*\)/\x1B[31m\1\x1B[39m/'
