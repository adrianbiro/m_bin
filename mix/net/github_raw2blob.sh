#!/bin/bash
#https://github.com/numpy/numpy/blob/main/doc/source/_static/numpy.css
#https://raw.githubusercontent.com/numpy/numpy/main/doc/source/_static/numpy.css

_URL="${1:-? Usage: ${0##*/} <raw_github_url>}"

sed -e 's#^https://raw.githubusercontent.com##' \
    -e 's#/#/blob/#3' \
    -e 's#^#https://github.com#' <<<"${_URL}"
