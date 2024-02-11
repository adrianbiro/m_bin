#!/bin/bash
#https://datatracker.ietf.org/doc/html/rfc7519
JWT="${1:?Usage: ${0##*/} <JWT>}"
OIFS="${IFS}"
IFS='.'
read -ra JWT_ARR <<<"${JWT}"
IFS=${OIFS}

header="$(base64 --decode <<< "${JWT_ARR[0]}")"
export claim; claim="$(base64 --decode <<< "${JWT_ARR[1]}")"
signature="${JWT_ARR[2]}"

echo "HEADER:"
jq '.'<<< "${header}"
echo "CLAIM:"
echo -e "\tIssued At: $(date -d "@$(jq -r '.iat'<<< "${claim}")")"
echo -e "\tExpire At: $(date -d "@$(jq -r '.exp'<<< "${claim}")")"
jq '.'<<< "${claim}"
echo "SIGNATURE:"
echo "${signature}"