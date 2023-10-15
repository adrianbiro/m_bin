#!/bin/bash

find /app/csops/import/ \( \( -name 'SFDW.HPDWHP.SMAPP1.DA*ERRS' -a -size 31c \) -o \( -name 'ASSC.ADSPP1.SMAPP1.FZ*ERRS' -a -size 59c \) -o \( -name 'CTBR.YB0A00.SMAPP1.SK*ERRS' -a -size 268c \) -o \( -name 'CLSC.CLMPP1.SMAPP1.VR*ERRS' -a -size 109c \) -o \( -name 'CLUN.CLMPP1.SMAPP1.UN*ERRS' -a -size 663c \) -o \( -name 'COLI.CSCOLL.SMAPP1.CI*ERRS' -a  -size 83c \) -o \( -name 'TMBR.CSCOLL.SMAPP1.AT*ERRS' -a -size 362c \) \) -print0 | xargs -n 1000 -0 mv -t /app/csops/archiv/

