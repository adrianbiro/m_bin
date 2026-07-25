#!/bin/sh
# shellcheck disable=SC2016

[ $# -eq 1 ] || {
    printf 'Usage:\n\t%s /dev/rmt6 > "/mnt/bkp/%s.out"\n', "${0##*/}", '$(date +"%Y-%m-%d_%H-%M-%S")'
    exit 1
}
device="${1}"
exec 3>&1
# https://unix.stackexchange.com/questions/18899/when-would-you-use-an-additional-file-descriptor
status=$( # return the dd exit status, not the grep, use file descriptors
    ( (
        dd if="${device}" ibs=64k 2>&1 1>&3 3>&- 4>&- #
        echo $? >&4
    ) | grep -E -v '^[0-9]+\+[0-9]+ records (in|out)$' 1>&2 3>&- 4>&-) 4>&1
)
exit "${status}"
