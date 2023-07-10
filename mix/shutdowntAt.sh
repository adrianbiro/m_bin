#!/bin/bash
if [[ -f "/run/systemd/shutdown/scheduled" ]]; then
    date -d "$(awk -F '=' '/USEC/{ 
        $2=substr($2,1,10); print $2 
        }' /run/systemd/shutdown/scheduled)"
else
    echo "No shutdown is scheduled."
fi
