#!/bin/bash
prog="${0##*/}"
function _help() {
    echo -e "Usage:
    ${prog} -i(H|B|D) -o(H|B|D) <num>"
    exit 1
}

while getopts 'hi:o:' OPTION; do
    case "$OPTION" in
    h) _help ;;
    i) ibase=$OPTARG 
        shift; next ;;
    o) obase=$OPTARG
        shift ;;
    *) _help ;;
    esac

done
echo $ibase $obase -- ${*}

#bc -lq <<<"ibase=${ibase};obase=${obase};255"
