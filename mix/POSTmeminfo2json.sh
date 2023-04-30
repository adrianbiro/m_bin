#!/bin/bash

URL=${1:-https://postman-echo.com/post}
TOKEN=${2:-987654321} 

json=$(
    awk 'BEGIN{
        printf "{"
    }
    {
        sub(":","",$1);
        printf "\"%s\":\"%s\",", $1, $2
    }
    END{
        print "}"
    }' /proc/meminfo | awk 'sub(",}","}",$0)' 
)
# post meminfo to watcher, run like cron
curl --request POST "${URL}" \
    --data "${json}" \
    --header 'Content-Type: application/json' \
    --header 'Accept-Charset: utf-8' \
    --header "Authorization: Bearer $(echo -n "${TOKEN}" | base64)" \
    --header 'Accept-Encoding: gzip, deflate, br' \
    --header 'Connection :keep-alive'
