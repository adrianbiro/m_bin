#!/bin/bash
PACKAGE="${1:? usage: ${0##*/} <package-name>}"

PACKAGE_split=("${PACKAGE//\// }")
PACKAGE_name=${PACKAGE_split[-1]}

mkdir "bin" 2>"/dev/null"

platforms=("windows/amd64" "linux/amd64")

for platform in "${platforms[@]}"; do
    #for platform in $(go tool dist list); do
    GOOS="${platform%%/*}"
    GOARCH="${platform##*/}"
    output_name="bin/${PACKAGE_name}-${GOOS}-${GOARCH}"
    if [[ "${GOOS}" = "windows" ]]; then
        output_name+='.exe'
    fi

    if ! env GOOS="${GOOS}" GOARCH="${GOARCH}" go build -o "${output_name}" "${PACKAGE}"; then
        echo 'An error has occurred! Aborting the script execution...'
        exit 1
    fi
done
