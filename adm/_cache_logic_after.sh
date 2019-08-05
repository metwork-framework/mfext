#!/bin/bash

function usage() {
    echo "usage: _cache_logic_after.sh SOURCE_DIR PREFIX"
}

if test "${2:-}" = ""; then
    usage
    exit 1
fi
if test "${1:-}" = "--help"; then
    usage
    exit 0
fi

SOURCE_DIR=$1
PREFIX=$2
CACHE_PATH=$(cat "${SOURCE_DIR}/cache/hash" 2>/dev/null)

if test "${CACHE_PATH}" = ""; then
    echo "ERROR: can't find ${SOURCE_DIR}/cache/hash"
    exit 1
fi
if test "${CACHE_PATH}" = "null"; then
    echo "no cache configured"
    exit 0
fi
if test -f "${CACHE_PATH}"; then
    echo "cache already exist (${CACHE_PATH})"
    rm -Rf "${SOURCE_DIR}/cache"
    exit 0
fi
if ! test -d "${SOURCE_DIR}/cache${PREFIX}"; then
    echo "ERROR: ${SOURCE_DIR}/cache${PREFIX} is not a directory"
    exit 1
fi

cd "${SOURCE_DIR}/cache${PREFIX}" && tar -cf "${CACHE_PATH}" .
if test $? -ne 0; then
    echo "ERROR: can't create ${CACHE_PATH}"
    rm -f "${CACHE_PATH}"
    exit 1
fi
echo "cache: ${CACHE_PATH} created"
rm -Rf "${SOURCE_DIR}/cache"
