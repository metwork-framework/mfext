#!/bin/bash

function usage() {
    echo "usage: _cache_logic_before.sh CACHE_LABEL SOURCE_DIR PREFIX LAYER_LABEL"
}

if test "${4:-}" = ""; then
    usage
    exit 1
fi
if test "${1:-}" = "--help"; then
    usage
    exit 0
fi

CACHE_LABEL=$1
SOURCE_DIR=$2
PREFIX=$3
LAYER_LABEL=$4

rm -Rf "${SOURCE_DIR}/cache"
mkdir -p "${SOURCE_DIR}/cache"
CACHE_PATH=$(_cache_path.sh "${CACHE_LABEL}" "${SOURCE_DIR}" "${LAYER_LABEL}")
echo "${CACHE_PATH}" >"${SOURCE_DIR}/cache/hash"

if test "${CACHE_PATH}" = "null"; then
    echo "no cache configured"
    exit 0
fi
if ! test -f "${CACHE_PATH}"; then
    echo "cache missed (${CACHE_PATH})"
    exit 0
fi

mkdir -p "${SOURCE_DIR}/cache${PREFIX}"
cd "${SOURCE_DIR}/cache${PREFIX}" && cat "${CACHE_PATH}" |tar xf -
if test $? -eq 0; then
    echo "cache hit (used: ${CACHE_PATH})"
else
    echo "corrupted cache ? (${CACHE_PATH}) => let's clean it"
    rm -f "${CACHE_PATH}"
fi
