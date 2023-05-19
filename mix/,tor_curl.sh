#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail
username=$(head -c 12 /dev/urandom | xxd -p)
# fix ipv6
ALL_PROXY="socks5://${username}:0@127.0.0.1:9050"
export ALL_PROXY

exec /usr/bin/curl "${@}"

