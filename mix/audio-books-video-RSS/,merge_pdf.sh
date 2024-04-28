#!/bin/bash

gs -q -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sOutputFile=out.pdf "${@}" #FreeBSD_Jails_Part_1.pdf FreeBSD_Jails_Part_2.pdf FreeBSD_Jails_Part_3.pdf FreeBSD_Jails_Part_4.pdf FreeBSD_Jails_Part_5.pdf

echo -e "\n\nFor result see:\n\t$(readlink -e out.pdf)"
