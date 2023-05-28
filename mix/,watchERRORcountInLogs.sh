#!/bin/bash

containter="${1:? Usage: ${0##*/} <smart-81>, optionaly set variables: string, location, seconds}"

while ((1)); do
   grep -c "${string:-ERROR}" "${location:-/srv/data/xp/openshift/appdata/remote/data02/smart-prod-applogs}/${containter}"* \
     | awk -F: '$NF>0{sum +=$NF}END{print sum}';
   sleep "${seconds:-1}";
 done