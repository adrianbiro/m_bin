# synology tasks

<https://github.com/adrianbiro/rotate_tar_or_rsync_backup>

Task name: Adrian_weekly_Backup_PC_Backup_rsync

user: adrian
weekly on sunday 01:00

```bash
cd /volume1/homes/adrian/Scripts && /bin/python3 /volume1/homes/adrian/Scripts/backup.py 2&>> /volume1/homes/adrian/Scripts/backup_logs.txt
```

```json
{
    "_COMMENT_SRC_DIR_BACKUP_DIR": "both has to exist before enabling backup",
    "SRC_DIR": "/volume1/homes/adrian/Automatic_bkp/PC_Backup_rsync",
    "BACKUP_DIR": "/volume1/homes/adrian/Automatic_bkp/PC_Backup_rsync_TASK_AUTO_BACKUP",
    "_COMMENT_PROJECT_NAME": "use for lableling backups",
    "PROJECT_NAME": "from_pc",
    "_COMMENT_RETENTION_PERIODS": "set retention higher then 0 to enable it",
    "BACKUP_RETENTION_HOURLY": 0,
    "BACKUP_RETENTION_DAILY": 0,
    "BACKUP_RETENTION_WEEKLY": 4,
    "BACKUP_RETENTION_MONTHLY": 0,
    "BACKUP_RETENTION_YEARLY": 0,
    "_COMMENT_BACKUP_TYPE": "only one can by set to true",
    "BACKUP_TYPE_TAR": false,
    "BACKUP_TYPE_RSYNC": true,
    "_COMMENT_CMD": "Command as argument lists, do not put SRC_DIR ot BACKUP_DIR here, you can adjust compression or ssh arhs for rsync here. '--verbose flags are captured by logging, enable debbug to see output'",
    "TAR_CMD": [
        "tar",
        "--create",
        "--gzip",
        "--verbose",
        "--file"
    ],
    "RSYNC_CMD": [
        "rsync",
        "--recursive",
        "--verbose",
        "--archive",
        "--copy-links"
    ],
    "_COMMENT_BACKUP_LOCATION_EXTENSION": "set to '.tar.gz' if you want to use tar backup type. Set to '/' or '' for rsync",
    "BACKUP_LOCATION_EXTENSION": ""
}
```