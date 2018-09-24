#!/bin/bash

BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
if test "${BRANCH}" = ""; then
    echo null
    exit 0
fi
if ! test -d /buildcache; then
    echo null
    exit 0
fi
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
${DIR}/_cache_hash.sh |md5sum |awk '{print $1;}'
