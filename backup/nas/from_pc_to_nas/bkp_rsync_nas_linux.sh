#!/bin/bash


REMOTE_LOCATION="nas.local:/var/services/homes/adrian/Automatic_bkp/PC_Backup_rsync"
REMOTE_HOST="nas.local"
REMOTE_CHOWN="adrian:users"

target_location="${REMOTE_LOCATION}/" #Intentional with /

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
#    "/home/adrian/.vim"
    "/opt/bin"
)



{ ping -c1 "${REMOTE_HOST}" > /dev/null ; } || {
    echo -e "Remote host: '${REMOTE_HOST}' is not online." 1>&2
    exit 0
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
    # -L transform symlink into referent file/dir
    #'--copy-links'
    '--delete'
    #"--exclude=${EXCLUDE_PATTERNS}"
    "${EXCLUDE_PATTERNS[@]}"
    # Idenity specific
    "--chown=${REMOTE_CHOWN}"
    #"--log-file=${LOG_FILE_LOCATION}"
    #-e "ssh -i ${REMOTE_SSH_KEY} -o StrictHostKeyChecking=no"
    #-e "ssh -F ${SSH_CONFIG} -o UserKnownHostsFile=${SSH_KNOWN_HOSTS}"
)


CMD=(rsync "${rsync_args[@]}" "${dirs_to_bkp[@]}" "${target_location}")

echo -e "Runnigng backup: $(date)\n\t${CMD[*]}"

"${CMD[@]}"

: <<'RESTORE_EXAMPLE'
rsync -rauvlPL --progress /d/{adrian_knihy,gits} $HOME/
rsync -rauvlPL --progress /mnt/mydisk/{adrian_knihy,gits,Applications,Templates} /home/adrian/
RESTORE_EXAMPLE