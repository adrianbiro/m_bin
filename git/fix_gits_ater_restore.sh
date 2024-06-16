sudo chown -R adrian:adrian "${GIST}"

find "${GITS}" -type d -name ".git" -prune -print0 | while IFS= read -r -d '' repo; do cd "${repo/.git}" && git reset --hard HEAD; done
