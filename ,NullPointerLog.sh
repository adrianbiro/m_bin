#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail
echo -e ""$(hostname)":$(readlink -f "${*}" | sed "s|${HOME}||g")\n"
awk '/^[0-3]?[0-9].[0-3]?[0-9].(?:[0-9]{2})?[0-9]{2}.*$/{print "\n" $0; next}{print}' "${@}"  | awk 'BEGIN{RS=""}/java.lang.NullPointerException/'
