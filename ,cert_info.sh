#!/bin/bash
DOMAIN="${1:-? Usage: ${0##*/} <example.com>}" #TODO
 
openssl s_client -connect "${DOMAIN}:443" -servername "${DOMAIN}" 2>/dev/null </dev/null | openssl x509 -noout -dates -issuer -subject
