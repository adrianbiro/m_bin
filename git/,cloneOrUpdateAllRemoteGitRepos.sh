#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

TOKEN=${TOKEN:?"export TOKEN='token_here'"}
NAME='adrianbiro'
OLDPWD="${PWD}"
GITSDIR="${HOME}/allgits"
readonly TOKEN NAME GITSDIR

function gitstuff {
  local gitrepo dirnamedotgit
  gitrepo="${1:?}" # git@github.com:adrianbiro/zfs_exporter.git
  dirnamedotgit="${gitrepo##*/}"  # zfs_exporter.git
  cd "${GITSDIR}" >"/dev/null" || return
  if [[ ! -d ".git" ]]; then
    cd "${dirnamedotgit}" || return
    git fetch --all --tags
  else
  echo "asd"
    git clone --mirror "${gitrepo}"
  fi
  : <<'END_COMMENT'
https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#list-repositories-for-the-authenticated-user
https://archive.kernel.org/oldwiki/git.wiki.kernel.org/index.php/Git_FAQ.html#How_do_I_clone_a_repository_with_all_remotely_tracked_branches.3F
https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token
END_COMMENT
}
function main {
  if [[ ! -d "${GITSDIR}" ]]; then
    mkdir "${GITSDIR}"
  fi

  local page
  declare -i page=1
  while :; do
    json=$(
      curl -s "https://api.github.com/users/$NAME/repos" -G \
        -d 'per_page=100' \
        -d "page=${page}" \
        -H 'Accept: application/vnd.github+json' \
        -H "Authorization:  Bearer $TOKEN" -H 'X-GitHub-Api-Version: 2022-11-28'
    )
    ((page++))
    if [[ $(echo "${json}" | jq '. | length') -eq 0 ]]; then
      break
    fi
    echo "${json}" | jq -r '.[].ssh_url' | while IFS="" read -r line; do
      gitstuff "${line}"
    done
  done
  cd "${OLDPWD}" || return
}
main "${@}"
