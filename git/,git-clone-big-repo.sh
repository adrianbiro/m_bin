#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail
# repo='ssh://git@<url:port>/smart.git'
repo=${1:?${0} <git repo to clone>}
extname=$(basename "${repo}")
name=${extname%.*}
# https://git-scm.com/docs/git-config default -1
git config --global core.compression 0 &&
	git clone --depth 1 "${repo}" &&
	cd "${name}" &&
	git fetch --unshallow &&
	git pull --all &&
	git config --global core.compression -1 &&
	unset repo extname name
cd -
