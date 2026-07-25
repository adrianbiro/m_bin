#!/bin/sh
mvn help:effective-pom | sed -E '/^(\[|Effective POMs,|$)/d' | bat -lxml --plain
