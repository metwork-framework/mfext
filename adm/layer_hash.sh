#!/bin/bash

BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
if test "${BRANCH}" = ""; then
    echo null
    exit 0
fi
if test "${BUILDCACHEUSER:-}" = ""; then
    echo null
    exit 0
fi
if test "${BUILDCACHEHOST:-}" = ""; then
    echo null
    exit 0
fi
if test "${BUILDCACHEDIR:-}" = ""; then
    echo null
    exit 0
fi
if test "${BUILDCACHEPASS:-}" = ""; then
    echo null
    exit 0
fi

set -eu

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LAYER="${1:-}"

OLDPWD=$(pwd)
cd "${DIR}/../layers"

# shellcheck disable=SC2010
LAYERS=$(ls |grep "^layer[0-9]_.*$")
cd "${OLDPWD}"

RES=$("${DIR}/_prelayers_hash.sh" |sort |md5sum |awk '{print $1;}')
for L in ${LAYERS}; do
    cd "${DIR}/../layers"
    TMPRES=$(git ls-tree "${BRANCH}" "${L}" |sort |md5sum |awk '{print $1;}')
    cd "${OLDPWD}"
    RES=$(echo "${RES} ${TMPRES}" |md5sum |awk '{print $1;}')
    if test "${L}" = "${LAYER}"; then
        break
    fi
done
echo "${RES}"
