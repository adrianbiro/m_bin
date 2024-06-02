#!/bin/bash
# https://unique-local-ipv6.com/#
printf 'fd%02x:%04x:%04x::/48\n' $((RANDOM % 255)) $((SRANDOM % 65535)) $((SRANDOM % 65535))

