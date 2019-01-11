#!/bin/bash

set -e

SRCDIR=${1:-}
if test "${SRCDIR:-}" = ""; then
    echo "usage: _build_cache_hash.sh SRC_DIR"
    exit 1
fi
SRCDIR=$(readlink -f "${SRCDIR}")
cd "${SRCDIR}"

git ls-tree HEAD |grep -v '\.git' |grep -v '\.md$' |grep -v '\.yml$' |grep -v '\.metwork-framework' >/tmp/build_cache_hash.$$
if test -f /etc/buildimage_hash; then
    cat /etc/buildimage_hash >>/tmp/build_cache_hash.$$
fi
if test "${DRONE_BRANCH:-}" != ""; then
    echo "${DRONE_BRANCH}" >>/tmp/build_cache_hash.$$
    if test "${DRONE_TAG:-}" != ""; then
        echo "tag${DRONE_TAG}" >>/tmp/build_cache_hash.$$
    fi
else
    git rev-parse --abbrev-ref HEAD 2>/dev/null |sed 's/-/_/g' >>/tmp/build_cache_hash.$$
fi

cat /tmp/build_cache_hash.$$ |md5sum |awk '{print $1;}'
rm -f /tmp/build_cache_hash.$$
