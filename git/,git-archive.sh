#!/bin/sh

name="$(git rev-parse --show-toplevel)"
name="${name##*/}-$(git rev-parse --verify --short HEAD).tar.xz"

git archive --format=tar "--prefix=FULLNAME/" HEAD | xz -9e > "${name}"

readlink -f "${name}"
