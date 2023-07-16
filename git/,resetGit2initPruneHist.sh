git pull
git checkout --orphan tmp-main
git add -A
git commit -m 'Initial commit'
git branch -D main
git branch -m main
git push -f origin main
git branch --set-upstream-to=origin/main main
git gc --aggressive --prune=all
git fetch --all
git reset --hard origin/main