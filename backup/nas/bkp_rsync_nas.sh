#!/bin/bash


REMOTE_LOCATION="nas.local:/var/services/homes/adrian/Automatic_bkp/PC_Backup_rsync"
REMOTE_HOST="nas.local"
SSH_CONFIG="/home/adrian/.ssh/config"
SSH_KNOWN_HOSTS="/home/adrian/.ssh/known_hosts"
REMOTE_CHOWN="adrian:users"
LOG_FILE_LOCATION="/var/log/bkp_rsync_nas.log"

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
    exit 123
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
    # nas specific settings
    "--chown=${REMOTE_CHOWN}"
    "${EXCLUDE_PATTERNS[@]}"
    "--log-file=${LOG_FILE_LOCATION}"
    #-e "ssh -i ${REMOTE_SSH_KEY} -o StrictHostKeyChecking=no"
    "-e ssh -F ${SSH_CONFIG} -o UserKnownHostsFile=${SSH_KNOWN_HOSTS}"
)


rsync "${rsync_args[@]}" "${dirs_to_bkp[@]}" "${target_location}"


: <<'RESTORE_EXAMPLE'
rsync -rauvlPL --progress /d/{adrian_knihy,gits} $HOME/
rsync -rauvlPL --progress /mnt/mydisk/{adrian_knihy,gits,Applications,Templates} /home/adrian/
RESTORE_EXAMPLE