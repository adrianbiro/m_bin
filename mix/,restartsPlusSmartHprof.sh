#!/bin/bash
# get *.hprof files
oc project smart-prod

oc get pods -o wide | awk 'NR==1{printf "%s,%s,%s\n", $1,$4,$5 ; next} /smart/{if($4 > 0) printf "%s,%s,%s\n", $1,$4,$5}' > "$(date -I).csv"

oc rsh "$(oc get pods -o wide | awk '/smart/{print $1; exit}')" sh -c 'chmod +666 /app/log/smart*.hprof'

scp -i ~/.ssh/id_rsa pplogss01.vs.csin.cz:/srv/data/xp/openshift/appdata/remote/data02/smart-prod-applogs/smart*.hprof .
