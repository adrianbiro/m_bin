#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

for i in $(docker images | awk 'NR >=2{ printf "%s:%s\n", $1, $2  }')
do
  nm=$(sed -e 's/\//_/g' <<< $i); # prevent invalid output path
  docker save -o "${nm}.tar" ${i}

done

# to restore: `docker load –i image.tar`


