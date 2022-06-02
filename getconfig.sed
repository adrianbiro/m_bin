#!/usr/bin/sed -Ef
1i ---------------------------
2i -- Working configuration --
# remove commented and blank lines
/^\s*(#|$)/d

# Usage:
# getconfig.sed /etc/ssh/ssh_config
