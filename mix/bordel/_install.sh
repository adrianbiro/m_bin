#!/bin/bash
function _sudo() {
    if ((0 == "$(id --user)")); then
        "$@"
    else
        sudo "$@"
    fi
}
_sudo find /opt/bin -maxdepth 1 ! -name "${0##*/}" -type f -executable -exec ln -sfv {} /usr/local/bin/ \;
