#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}/.."

git ls-tree HEAD |grep -v "README.md" |grep -v "CHANGELOG.md" >/tmp/build_cache_hash.$$
if test -f /etc/buildimage_hash; then
    cat /etc/buildimage_hash >>/tmp/build_cache_hash.$$
fi
cat "${DIR}/../adm/root.mk" |grep _HOME >>/tmp/build_cache_hash.$$

cat /tmp/build_cache_hash.$$ |md5sum |awk '{print $1;}'
rm -f /tmp/build_cache_hash.$$
