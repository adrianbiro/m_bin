#!/bin/bash

pushd "${PWD}" >"/dev/null" || return
trap "popd >'/dev/null' || return" EXIT

# shellcheck source=/dev/null
source ~/.git-refresh-conf
:<<'END_COMMENT'
SSH_KEY="${HOME}/.ssh/ed25519"
REPOS="${HOME}/src"
IGNORE_GREP_REGEX='(terraform|ghp|gsoc)'
END_COMMENT

# Unlock key
eval "$(ssh-agent)"
eval "$(ssh-agent)"
echo "${SSH_KEY}"
ssh-add "${SSH_KEY}"

find "${REPOS}" -mindepth 1 -maxdepth 1 -type d -print0 | while IFS= read -r -d '' repo; do
    cd "${repo}" || return
    [[ -d ".git" ]] || return
    { grep -qv "${IGNORE_GREP_REGEX}"; } && { #IGNORE
        pwd
        git fetch --all --update-head-ok                                        # https://stackoverflow.com/a/19205680/18172103
        git pull origin "$(git branch | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')" # TODO all branches
    }
done
