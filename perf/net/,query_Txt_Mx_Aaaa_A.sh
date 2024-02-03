#!/bin/bash

[[ -z "${1}" ]] && {
    echo -e "
Usage:
    ${0##*/} <example.com>

Records:
    A, AAAA, MX, TXT, SPF
Servers:
    OpenDNS
    Yandex.DNS
    dns0.eu
    Dyn
    Quad9
    Cloudflare
    DNS.Watch
    Level3
    Hurricane Electric
    Google Public DNS
    Comodo Secure DNS"

    exit 1
}
domain="${1}"

curl --silent \
    -G 'https://www.netmeister.org/puddy/index.cgi' \
    -d type=a,aaaa,mx,txt,spf \
    -d format=json \
    -d lookup=normal \
    -d country=default \
    -d name="${domain}"
