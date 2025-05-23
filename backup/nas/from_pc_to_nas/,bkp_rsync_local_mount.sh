#!/bin/bash

MOUNT_LOCATION="/mnt/mydisk"
target_location="${MOUNT_LOCATION}/" #Intentional with /

EXCLUDE_PATTERNS=(
    "--exclude=**/venv/**"
    "--exclude=**/node_modules/**"
    "--exclude=**/target/**" #maven
    "--exclude=**/stratocyberlab/ollama/**"
)

dirs_to_bkp=(
    "/home/adrian/adrian_knihy"
    "/home/adrian/gits"
    "/home/adrian/Applications"
    "/home/adrian/Templates"
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
    #"--exclude=${EXCLUDE_PATTERNS}"
    "${EXCLUDE_PATTERNS[@]}"
)
: <<'END_TODO_REMOTE_TIME_MACHINE_LIKE'
#https://github.com/basnijholt/rsync-time-machine.py
        '-D'
        '--numeric-ids'
        '--links'
        '--hard-links'
        '--one-file-system'
        '--itemize-changes'
        '--times'
        '--recursive'
        '--perms'
        '--owner'
        '--group'
        '--stats'
        '--human-readable'

END_TODO_REMOTE_TIME_MACHINE_LIKE

rsync "${rsync_args[@]}" "${dirs_to_bkp[@]}" "${target_location}"


: <<'RESTORE_EXAMPLE'
rsync -rauvlPL --progress /d/{adrian_knihy,gits} $HOME/
rsync -rauvlPL --progress /mnt/mydisk/{adrian_knihy,gits,Applications,Templates} /home/adrian/
RESTORE_EXAMPLE