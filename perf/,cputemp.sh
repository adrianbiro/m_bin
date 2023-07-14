#!/bin/bash

find /sys/class/thermal/thermal_zone*/ -maxdepth 0 -print0 | while IFS= read -r -d '' dir; do
    echo "$(cat "${dir}"/type): $(sed 's/\(.\)..$/.\1°C/' "${dir}/temp")"
done
