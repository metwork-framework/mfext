#!/bin/bash

function usage() {
    echo "usage: make_custom_wrapper.sh COMA_SEPARATED_LIST_OF_LAYER_LABELS COMMAND WRAPPER_DESTINATION_FULLPATH"
}

if test "${1:-}" = ""; then
    usage
    exit 1
else
    export LAYERS="$1"
fi
if test "${2:-}" = ""; then
    usage
    exit 1
else
    export COMMAND="$2"
fi
if test "${3:-}" = ""; then
    usage
    exit 1
else
    export TARGET="$3"
fi

SOURCE="${MFEXT_HOME}/share/templates/custom_wrapper.c"
if ! test -f "${SOURCE}"; then
    echo "ERROR: ${SOURCE} NOT FOUND"
    exit 1
fi
CUSTOM_SOURCE="/tmp/custom_wrapper_$$.c"
cat "${SOURCE}" |sed "s!{{LAYERS}}!${LAYERS}!g" |sed "s!{{COMMAND}}!${COMMAND}!g" >"${CUSTOM_SOURCE}"
CC=gcc
CFLAGS="-std=c99 -Wall -Wextra -pedantic -Werror -Wshadow -Wstrict-overflow -fno-strict-aliasing -fPIC -DG_LOG_DOMAIN=\"layerapi2\" -Wl,-rpath=${MFEXT_HOME}/lib"
${CC} -o "${TARGET}" ${CFLAGS} $(pkg-config --cflags --libs layerapi2) "${CUSTOM_SOURCE}"
rm -f "${CUSTOM_SOURCE}"
