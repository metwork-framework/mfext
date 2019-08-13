#!/bin/bash

function usage() {
    echo "usage: _cache_logic_after_layer.sh LAYER_HOME"
}

if test "${1:-}" = "--help"; then
    usage
    exit 0
fi
if test "${1:-}" = ""; then
    usage
    exit 1
fi

CACHE_PATH=$(cat "cache/hash" 2>/dev/null)
LAYER_HOME=${1}

if test "${CACHE_PATH}" = ""; then
    rm -Rf "cache"
    echo "ERROR: can't find cache/hash"
    exit 1
fi
if test "${CACHE_PATH}" = "null"; then
    rm -Rf "cache"
    echo "no cache configured"
    exit 0
fi
if test -f "${CACHE_PATH}"; then
    echo "cache already exist (${CACHE_PATH})"
    rm -Rf "cache"
    exit 0
fi

cd "$(dirname "${LAYER_HOME}")" && tar -cf "${CACHE_PATH}" "$(basename "${LAYER_HOME}")"
if test $? -ne 0; then
    echo "ERROR: can't create ${CACHE_PATH}"
    rm -f "${CACHE_PATH}"
    exit 1
fi
echo "cache: ${CACHE_PATH} created"
rm -Rf "cache"
