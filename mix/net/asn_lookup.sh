#!/bin/bash
function _asn {
    [[ -n $1 ]] && {
        echo -e "begin\nverbose\n${1}\nend" | netcat whois.cymru.com 43 | tail -n +2
        return
    }
    (
        echo -e 'begin\nverbose'
        cat -
        echo end
    ) | netcat whois.cymru.com 43 | tail -n +2
}
 _asn "${@}"


: <<'END_COMMENT'
Single IP:
	asn_lookup.sh 1.1.1.1
IPs in bulk:
	cat ip.txt | asn_lookup.sh
https://www.arin.net/resources/guide/asn/     
END_COMMENT
