#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail
for i in $HOME/Applications/*;
  do
    namesh=$(basename $i)".sh"
    if [[ "${namesh}" == "venv.sh" ]]; then
      continue
    fi
    #echo ${i} > ".local/share/nemo/scripts/${namesh}"
    echo ${i} > ".local/share/nemo/scripts/${namesh}"
    #chmod +x ${namesh}
  done

# fixname in script menu from Beekeeper-Studio-3.6.2_b0597e83dc419d3aac93bc5e424ae848.AppImage.sh to Beekeeper-Studio-3.6.2.sh
rename 's/(\w+)_.*/\1\.sh/' ~/.local/share/nemo/scripts/*
