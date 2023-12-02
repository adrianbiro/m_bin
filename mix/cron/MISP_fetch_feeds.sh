#!/bin/bash

URL="https://misp.local/feeds/fetchFromAllFeeds"

PROGRAM_NAME="${0##*/}"

function _logger() {

    logger --id=$$ --tag "${USER} ${PROGRAM_NAME}" "${*}"
}

function _curl() {
    curl --silent --fail --show-error "${@}" 2>&1
}

out="$(_curl ${URL})"
_logger "${out}"

: <<'END_COMMENT'
https://www.misp-project.org/openapi/#tag/Feeds/operation/fetchFromAllFeeds
To see logs:
    tail -f /var/log/syslog
Install cronjob:
    crontab -u <USER> -e
    0 0 0 0 * /opt/misp/tools/MISP_fetch_feeds.sh
END_COMMENT
