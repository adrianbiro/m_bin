#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail
if [[ -z "${1:-}" || ! -f "${1:-}" ]]; then
  echo -e "Usage:\n\t${0##*/} <file.log>"
  exit 1
fi
echo -e "$(hostname):$(readlink -f "${1:?}" | sed "s|${HOME}||g")\n"
awk '/^[0-3]?[0-9].[0-3]?[0-9].(?:[0-9]{2})?[0-9]{2}.*$/{print "\n" $0; next}{print}' "${1:?}" |
  awk 'BEGIN{RS=""}/java.lang.NullPointerException/'
