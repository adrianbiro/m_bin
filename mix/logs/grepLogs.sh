#!/bin/bash

# Count ERROR in logs from container for all replocas not just one pod

grep -c ERROR "log/$(sed 's/\(.*\)-.*/\1/' /etc/hostname)*" | awk -F: '$NF>0{sum += $NF}END{print sum}'

: <<'SAME_IN_LOOP'
while ((1)); do grep -c ERROR "log/$(sed 's/\(.*\)-.*/\1/' /etc/hostname)*" | awk -F: '$NF>0'; sleep 1; done
SAME_IN_LOOP


: <<'END_COMMENT'
    # count CRITICAL
grep -F -c CRITICAL {accounts*,alien*,beran*,bop*,bpm*,bti*,burda*,car*,cebro*,cedr*,cem*,cfc*,charon*,cia*,cim2*,col*,corporate*,corps*,coxy*,dabra*,dam*,dia*,dmclaim*,dmh*,dmrules*,eom*,esig2*,estorage*,flint*,foc*,focup*,fx*,gauth*,gcedr*,gdpr*,gmnt*,her*,hub3*,im-ui*,ima*,imb*,imcr*,imf*,imrep*,imtp*,inv*,iq*,kiosk-ui*,krab*,kyc*,liab*,loan*,mac*,macbl*,maccm*,macpm*,mit*,mnt*,mobilita*,mock*,monitor*,mse*,ngruntime*,notif*,nq*,oauth2-proxy*,olin*,ore*,pac*,pam*,passbook*,pens*,ponk*,rebox*,redis-cluster*,redis-cluster-headless*,redis-cluster-metrics*,redis-commander*,rim*,rkt*,roxy*,sbsc*,ses*,sigma*,smart*,sud*,task*,tia*,totem*,tsign*,ufo*,uka*,uno2*,unorip*,vchod*}
    # append at the end to filter perrmision errors and zeroes
2>/dev/null | awk -F: '$NF>0'
END_COMMENT