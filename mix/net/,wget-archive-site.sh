#!/usr/bin/env bash

WGETREJECT='*.img,*.md*,*.dsk,*.nrg,*.iso,*.cue,*.pk*,*.pk0,*.pk1,*.pk2,*.pk3,*.pk4,*.pak*,*.daa,*.ass,*.ipa,*.ace,*.toast,*.vcd,*.vol,*.bak,*.cab,*.tmp'
WGETREJECT_ARCHIVE=',*.lz,*.gz,*.zip,*.rar,*.7z,*.tar*,*.xz,*.bz2'
WGETREJECT_PROGRAM=',*.exe,*.deb,*.rpm,*.dmg,*.bin,*.msi,*.apk,*.tar.*z'

WGETREJECT="${WGETREJECT}${WGETREJECT_ARCHIVE}${WGETREJECT_PROGRAM}"



URL="$1"

DOMAIN="${URL}"
DOMAIN="${DOMAIN#https://}"
DOMAIN="${DOMAIN#ftp://}"
DOMAIN="${DOMAIN#scp://}"
DOMAIN="${DOMAIN#scp://}"
DOMAIN="${DOMAIN#sftp://}"
DOMAIN="${DOMAIN#*:*@}"
DOMAIN="${DOMAIN#*@}"
DOMAIN=${DOMAIN%%/*}

WORKING_DIR="$HOME/Downloads/archive-${DOMAIN}-$(date +%Y-%m-%d_%H-%M-%S)"


wget -r -p -k -c --trust-server-names --level=10 \
  --timeout=3s --no-check-certificate -e robots=off --wait=0.4 \
  --tries=6 --reject "${WGETREJECT}" \
    --user-agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36" \
	--header="X-Requested-With: XMLHttpRequest" \
  --referer="$DOMAIN" --header='Accept-Language: en' \
	--directory-prefix="$WORKING_DIR" \
	"${URL}"