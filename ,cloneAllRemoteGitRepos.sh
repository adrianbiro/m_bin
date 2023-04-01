#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

TOKEN=${TOKEN:?"export TOKEN='token_here'"}
NAME='adrianbiro'
OLDPWD="${PWD}"
GITSDIR="${HOME}/allgits"
TOUPDATE=()

function gitstuff {
  local gitrepo dirnamedotgit dirname
  gitrepo="${1:?}"                # git@github.com:adrianbiro/zfs_exporter.git
  dirnamedotgit="${gitrepo##*/}"  # zfs_exporter.git
  dirname="${dirnamedotgit%.git}" # zfs_exporter
  cd "${GITSDIR}" >"/dev/null" || return
  # if there is repo update it #TODO update
  #if echo "${TOUPDATE[*]}" | grep -q "${dirname}"; then
  #  cd "${GITSDIR}/${dirname}" #|| return
  #  git fetch --all
  #else
  : <<'END_COMMENT'
https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#list-repositories-for-the-authenticated-user
https://archive.kernel.org/oldwiki/git.wiki.kernel.org/index.php/Git_FAQ.html#How_do_I_clone_a_repository_with_all_remotely_tracked_branches.3F
https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token
END_COMMENT
  #if [[ $(ls -A | wc -l) -eq 0 ]]; then
  git clone --mirror "${gitrepo}" "${dirname}/.git"
  cd "${GITSDIR}/${dirname}" || return
  git config --bool core.bare false && git checkout "$(git branch --show-current)" >"/dev/null"
  # fi
}
function main {
  if [[ ! -d "${GITSDIR}" ]]; then
    mkdir "${GITSDIR}"
  fi

  mapfile -d $'\0' TOUPDATE < <(find "${GITSDIR}" -type d -name ".git" -prune -print0)

  local page
  page=1
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
