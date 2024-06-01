#!/bin/bash

:"${USER_PASSWORD:?"export USER_PASSWORD='user:password'"}"

EMAILS="${1:?  Usage: ${0##*/} <user@example.com,user@google.com>}"

EMAILS="$(echo "${EMAILS}" | tr ',' '\n' | sed -E "s/(.*)/{inputData: '\1' },/" | sed '$ s/,$//')" #create array of objects, and remove last ','

curl -s -u "${USER_PASSWORD}" \
    --compressed -H "Content-Type: application/json" \
    -d "{ entries: [ ${EMAILS} ] }" \
    'https://api.verifalia.com/v2.6/email-validations' | jq '.'
