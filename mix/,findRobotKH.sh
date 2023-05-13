#!/bin/bash
# ROBOT-KH

find /srv/app/sandbox-storage/ -maxdepth 3 -regextype posix-extended -regex ".*(docx|txt|tsv|csv|pdf|json|zip)" -mtime +30 -type f -delete