#!/bin/bash

MOUNT_LOCATION="/mnt/mydisk"
EXCLUDE_PATTERNS='**/venv/**'        # rsync --exclude=
target_location="${MOUNT_LOCATION}/" #Intentional with /

dirs_to_bkp=(
    "/home/adrian/adrian_knihy"
    "/home/adrian/gits"
    "/home/adrian/Applications"
    "/home/adrian/.vim"
    "/opt/bin"
)

[[ "${EUID}" -eq 0 ]] || {
    echo "This script must be run as root!" 1>&2
    exit 1
}
{ mountpoint "${MOUNT_LOCATION}" -q; } || {
    echo -e "Mount it in to:\n\t${MOUNT_LOCATION}" 1>&2
    exit 1
}

for i in "${dirs_to_bkp[@]}"; do
    [[ -d "${i}" ]] || {
        echo "${i} does not exists!" 1>&2
        exit 1
    }
done

#-rauvlP
rsync_args=(
    '--recursive'
    # -a archive mode is -rlptgoD (no -A,-X,-U,-N,-H) https://www.baeldung.com/linux/rsync-archive-mode
    '--archive'
    # -u skip files that are newer on the receiver
    '--update'
    '--verbose'
    # -l copy symlinks as symlinks
    '--links'
    '--progress'
    # -L transform symlink into referent file/dir
    #'--copy-links'
    '--delete'
    "--exclude=${EXCLUDE_PATTERNS}"
)

rsync "${rsync_args[@]}" "${dirs_to_bkp[@]}" "${target_location}"
