#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

#GITSDIR="${HOME}/allgits"
GITSDIR="/home/adrian/Downloads/allgits"
readonly GITSDIR

function gitstuff {
  local gitrepo dirnamedotgit
  gitrepo="git@github.com:${1:?}"               # adrianbiro/zfs_exporter.git
  dirnamedotgit="${gitrepo##*/}" # zfs_exporter.git
  cd "${GITSDIR}" >"/dev/null" || return
  test ! -d "${dirnamedotgit}" && {
    echo -e "\nNEW"
    git clone --mirror "${gitrepo}"
    return
  }

  echo -e "\nOLD"
  cd "${dirnamedotgit}" || return
  git fetch --all --tags


}
function main {
  pushd "${PWD}" >"/dev/null" || return
  trap "popd >'/dev/null' || return" EXIT
  
  if [[ ! -d "${GITSDIR}" ]]; then
    mkdir "${GITSDIR}"
  fi

 gh repo list --limit 5000 | cut -f1 | while IFS="" read -r line; do
    gitstuff "${line}"
  done
  
}


main "${@}"

:<<'END_COMMENT'
gh auth login
END_COMMENT