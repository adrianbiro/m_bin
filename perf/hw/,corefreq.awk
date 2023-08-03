#!/bin/sh
awk '
BEGIN {	FS = ":" }

$1 ~ /^processor[[:space:]]+$/ { Processor = $2 }

$1 ~ /^cpu MHz[[:space:]]+$/ { Cores[Processor] = $2 }

END { for (Processor in Cores) { printf("CORE_%d: %d\n", Processor + 1, Cores[Processor]) }
}' /proc/cpuinfo

# https://www.baeldung.com/linux/proc-cpuinfo-flags