#!/bin/bash

function usage() {
    echo "usage: _cache_logic_before_layer.sh LAYER_HOME LAYER_NAME"
}

if test "${2:-}" = ""; then
    usage
    exit 1
fi
if test "${1:-}" = "--help"; then
    usage
    exit 0
fi
LAYER_HOME=$1
LAYER_NAME=$2
LAYER_LABEL="${LAYER_NAME}@${MODULE_LOWERCASE}"
PW=$(pwd)

rm -Rf "${PW}/cache"
mkdir -p "${PW}/cache"
CACHE_PATH=$(_cache_path.sh "layer_${LAYER_NAME}" . "${LAYER_LABEL}" IGNORE_SELF)
echo "${CACHE_PATH}" >"${PW}/cache/hash"

if test "${CACHE_PATH}" = "null"; then
    echo "no cache configured"
    exit 0
fi
if ! test -f "${CACHE_PATH}"; then
    echo "cache missed (${CACHE_PATH})"
    exit 0
fi

cd "$(dirname "${LAYER_HOME}")" && rm -Rf "$(basename "${LAYER_HOME}")" && cat "${CACHE_PATH}" |tar xf -

if test $? -eq 0; then
    echo "cache hit (used: ${CACHE_PATH})"
    touch "${PW}/cache/hit"
else
    echo "corrupted cache ? (${CACHE_PATH}) => let's clean it"
    rm -f "${CACHE_PATH}"
fi
