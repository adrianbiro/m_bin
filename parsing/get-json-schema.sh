#!/bin/sh
jq -r 'path(..) | map(tostring) | join("/")' "${1}"