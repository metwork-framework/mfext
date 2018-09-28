#!/bin/bash

set -e

SRCDIR=${1:-}
if test "${SRCDIR:-}" = ""; then
    echo "usage: _build_cache_hash.sh SRC_DIR"
    exit 1
fi
SRCDIR=$(readlink -f "${SRCDIR}")
cd "${SRCDIR}"

git ls-tree HEAD |grep -v "README.md" |grep -v "CHANGELOG.md" >/tmp/build_cache_hash.$$
if test -f /etc/buildimage_hash; then
    cat /etc/buildimage_hash >>/tmp/build_cache_hash.$$
fi
cat "${SRCDIR}/adm/root.mk" |grep _HOME >>/tmp/build_cache_hash.$$

cat /tmp/build_cache_hash.$$ |md5sum |awk '{print $1;}'
rm -f /tmp/build_cache_hash.$$
