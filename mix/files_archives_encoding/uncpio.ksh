#!/usr/bin/mksh

function _help {
    printf "%s - unarchive cpio archive.\nUsage:\n\t%s [-vu] <file.cpio>\n\t%s\n\t%s\n" \
        "${1##*/}" "${1##*/}" \
        "-v     print extracted file names" \
        "-u     unconditionally overwrite existing files"

    exit 1
}
TODO='./uncpio.ksh -u zmaz.cpio
E: ./uncpio.ksh[21]: -a: unknown option
-idmu zmaz.cpio'

CpioOpt="idm"
while getopts vuh opt; do
    case "$opt" in
    h) _help "${0}" ;;
    v) CpioOpt="${CpioOpt}v" ;;
    u) CpioOpt="${CpioOpt}u" ;;
    *) break ;;
    esac
    shift
done

[[ ${#} -eq 1 ]] || _help "${0}"

for i in "${@}"; do
    [[ -r "${i}" ]] || {
        echo "File: ${i} should exists and you need read permissions"
        exit 1
    }
    #cpio "-${CpioOpt}" <"${i}"
    echo "-${CpioOpt} ${i}"
done
