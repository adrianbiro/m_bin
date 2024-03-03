#!/bin/sh
prog="${HOME}/bin/,shiftlines.sh"
mkdir -p "${prog%/*}"
cat <<'END_PROG' > "${prog}"
#!/bin/bash
if [ ${#} -eq 0 ]; then printf "Usage:\n\t%s <input_file> <output_file> <number_lines_to_shift>\n" "${0##*/}"; exit 1; fi
infile=${1:?}
outfile=${2:?}
numlines=${3:?}

# add header
head -n 1 "${infile}" >>"${outfile}"
# skip header shift first N lines 2-n
# shellcheck disable=SC2086
sed -i -e 2,${numlines}$'{w/dev/stdout\n;d}' "${infile}" >>"${outfile}" ## todo in posix shell bash works Bashism $'..'

END_PROG

chmod +x "${prog}"
# shellcheck disable=2016
printf 'Run:\n\texport PATH="$HOME/bin:$PATH"\n'

# shellcheck disable=SC2016,SC2034
Deploy=:<<'END_COMMENT'
# up-to not including the match
sed '/Deploy/Q' ,shiftLinesPodBootstrap.sh | base64 --wrap=0 | Set-Clipboard

echo <base64_string> | base64 -d -w 0 | sh

echo 'IyEvYmluL3NoCnByb2c9IiR7SE9NRX0vYmluLyxzaGlmdGxpbmVzLnNoIgpta2RpciAtcCAiJHtwcm9nJS8qfSIKY2F0IDw8J0VORF9QUk9HJyA+ICIke3Byb2d9IgojIS9iaW4vYmFzaAppZiBbICR7I30gLWVxIDAgXTsgdGhlbiBwcmludGYgIlVzYWdlOlxuXHQlcyA8aW5wdXRfZmlsZT4gPG91dHB1dF9maWxlPiA8bnVtYmVyX2xpbmVzX3RvX3NoaWZ0PlxuIiAiJHswIyMqL30iOyBleGl0IDE7IGZpCmluZmlsZT0kezE6P30Kb3V0ZmlsZT0kezI6P30KbnVtbGluZXM9JHszOj99CgojIGFkZCBoZWFkZXIKaGVhZCAtbiAxICIke2luZmlsZX0iID4+IiR7b3V0ZmlsZX0iCiMgc2tpcCBoZWFkZXIgc2hpZnQgZmlyc3QgTiBsaW5lcyAyLW4KIyBzaGVsbGNoZWNrIGRpc2FibGU9U0MyMDg2CnNlZCAtaSAtZSAyLCR7bnVtbGluZXN9JCd7dy9kZXYvc3Rkb3V0XG47ZH0nICIke2luZmlsZX0iID4+IiR7b3V0ZmlsZX0iICMjIHRvZG8gaW4gcG9zaXggc2hlbGwgYmFzaCB3b3JrcyBCYXNoaXNtICQnLi4nCgpFTkRfUFJPRwoKY2htb2QgK3ggIiR7cHJvZ30iCiMgc2hlbGxjaGVjayBkaXNhYmxlPTIwMTYKcHJpbnRmICdSdW46XG5cdGV4cG9ydCBQQVRIPSIkSE9NRS9iaW46JFBBVEgiXG4nCgojIHNoZWxsY2hlY2sgZGlzYWJsZT1TQzIwMTYsU0MyMDM0Cg==' | base64 -d -w 0 | sh

END_COMMENT