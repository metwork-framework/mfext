#!/bin/bash

set -eu

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

git ls-tree "${BRANCH}" bootstrap.sh adm Makefile layerapi2 glib2 mfutil_c config layers/layer7_devtools/0000_penvtpl

cd "${DIR}/../layers" && git ls-tree "${BRANCH}" |grep -v "layer[0-9]_.*"
cat "${DIR}/root.mk" |grep -v "_VERSION" |sort
if test -f /etc/buildimage_hash; then
    cat /etc/buildimage_hash
fi
