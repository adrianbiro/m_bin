#!/usr/bin/sed -Ef
#https://www.ibm.com/docs/en/was-liberty/base?topic=SSEQTP_liberty%2Fcom.ibm.websphere.wlp.doc%2Fae%2Frwlp_xml_escape.htm

s/&quot;/"/g

s/&apos;/'/g

s/&lt;/</g

s/&gt;/>/g

#https://stackoverflow.com/a/25273781/18172103
s/&amp;amp;/\&/g

s/&amp;/\&/g
