#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

git fetch --all
git pull --all

branches=$(git branch --all | grep '^\s*remotes' | egrep --invert-match '(:?HEAD|master|main)$')
for b in $branches;
do
  git branch --track "${b##*/}" "${b}";
done
