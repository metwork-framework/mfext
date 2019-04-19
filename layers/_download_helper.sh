#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PROXY_SET=$(_proxy_set.sh)

if test "${PROXY_SET}" = "0"; then
    unset http_proxy
    unset https_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
fi

ARCHIVE_FILE=$1
SOURCES_FILE=$2
CHECKSUM_TYPE=$3
CHECKSUM_VALUE=$4
TIMEOUT=$5
if test "${TIMEOUT}" = ""; then
    TIMEOUT=120
fi

DIR=$(dirname "${ARCHIVE_FILE}")
if ! test -d "${DIR}"; then
    mkdir -p "${DIR}"
fi

"${CURRENT_DIR}/_checksum_helper.sh" "${ARCHIVE_FILE}" "${CHECKSUM_TYPE}" "${CHECKSUM_VALUE}"
N=$?
if test ${N} -eq 0; then
    exit 0
fi

SUCCESS=0
for SOURCE in $(cat "${SOURCES_FILE}"); do
    rm -f "${ARCHIVE_FILE}"
    echo "Trying to download ${SOURCE}..."
    wget --no-check-certificate --tries=3 --timeout=${TIMEOUT} -O "${ARCHIVE_FILE}" "${SOURCE}"
    if test $? -eq 0; then
        "${CURRENT_DIR}/_checksum_helper.sh" "${ARCHIVE_FILE}" "${CHECKSUM_TYPE}" "${CHECKSUM_VALUE}"
        N=$?
        if test ${N} -eq 0; then
            SUCCESS=1
            break
        fi
    fi
done

if test ${SUCCESS} -eq 0; then
    echo "ERROR: can't download a valid archive for source file ${SOURCES_FILE} (checksum: ${CHECKSUM_TYPE}/${CHECKSUM_VALUE})"
    rm -f "${ARCHIVE_FILE}"
    exit 1
fi

exit 0
