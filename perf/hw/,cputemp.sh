#!/bin/bash

find /sys/class/thermal/thermal_zone*/ -maxdepth 0 -print0 | while IFS= read -r -d '' dir; do
    echo "$(cat "${dir}"/type): $(sed 's/\(.\)..$/.\1°C/' "${dir}/temp")"
done

docs=:<<'END_COMMENT'

temp stores 54000 millidegree Celsius, that means 54°C

https://www.kernel.org/doc/Documentation/thermal/x86_pkg_temperature_thermal
https://www.kernel.org/doc/Documentation/thermal/sysfs-api.txt
END_COMMENT
