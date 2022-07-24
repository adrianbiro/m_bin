#!/bin/bash

NOT_NORMAL=90

function main()
{
  while true; do
    percent_mem=$(free | awk 'NR==2{print int($3*100/$2)}')
    msg="\e[36mNormal value.\033[0m"
    if (( $percent_mem > $NOT_NORMAL )); then
      msg="\e[31;5m!!!!!!\033[0m\nMemory is to high!"
    fi

    echo -e $msg

    sleep 20

  done
}

main
