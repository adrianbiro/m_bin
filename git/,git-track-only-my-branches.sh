#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

git fetch --all --prune
branch="$(git rev-parse --abbrev-ref origin/HEAD | cut -d/ -f2-)"
git config --add remote.origin.fetch "+refs/heads/${branch}:refs/remotes/origin/${branch}"
# $USER-branch_name
git config --add remote.origin.fetch "+refs/heads/${USER}-*:refs/remotes/origin/${USER}-*"
# on NTFS it takes time
# on git-bash git for-each-ref | awk '{print $3}' 
git for-each-ref --format='%(refname)' | grep -Ev "^(refs/heads/|refs/remotes/origin/(HEAD$|${branch}$|${USER}-))" | xargs -I{} -n1 git update-ref -d {}

# git branch -r  

## to clone another branch
# git fetch origin BRANCH_NAME_HERE
# git checkout FETCH_HEAD -b BRANCH_NAME_HERE
