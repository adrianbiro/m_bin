#!/bin/bash

# sum errors in log gile 2 days old
find /srv/log/xp/openshift/appdata/smart-prod-applogs -newermt "$(date -d "2 day ago" +"%Y-%m-%d")" ! -newermt "$(date +"%Y-%m-%d")"  -name "burda-*" -exec zgrep -c ERROR {} \; | awk  '{sum+=int($0)}END{print sum}'

# print log file name, plus print errors with ../,parserLog4j.py  
find /srv/log/xp/openshift/appdata/smart-prod-applogs -newermt "$(date -d "2 day ago" +"%Y-%m-%d")" ! -newermt "$(date +"%Y-%m-%d")" -name "burda-*" -print0 | while IFS= read -r -d '' file; do if "$(zgrep -qm 1 ERROR "${file}")"; then  echo "${file}"; ~/bin/,parseLog4j.py -e 'ERROR' "${file}"; fi; done
