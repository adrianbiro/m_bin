#!/bin/bash


function fun_get ()
{
  local filename; filename="$(date --iso-8601)_failed_root.txt"
  journalctl -u ssh \
    | awk -F ' ' '/Failed password for root /{ print $11 | "sort -u" }' \
    > "${filename}" && cat "${filename}"
}


function fun_add ()
{
  local filename; filename=$2
  while read -r line ;
  do
    ufw prepend deny from "$line"
  done < "$filename"
}


case ${1} in
  --get) fun_get ;;
  --add) fun_add "$@" ;;
esac
