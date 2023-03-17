#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail
awk '/java.lang.NullPointerException/,/^[0-3]?[0-9].[0-3]?[0-9].(?:[0-9]{2})?[0-9]{2}.*$/' ${1:?"Usage: ${0} <logfile>"}
