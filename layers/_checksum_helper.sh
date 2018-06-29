#!/bin/bash

ARCHIVE_FILE=$1
CHECKSUM_TYPE=$2
CHECKSUM_VALUE=$3

if ! test -f ${ARCHIVE_FILE}; then
    exit 1
fi

if test "${CHECKSUM_TYPE}" = "NONE"; then
    if test -s ${ARCHIVE_FILE}; then
        echo "No checksum to compute but size > 0 => success"
        exit 0
    else
        echo "Empty file"
        exit 1
    fi
else
    echo "Computing checksum for ${ARCHIVE_FILE}..."
    if test "$CHECKSUM_TYPE" = "MD5"; then
        CHECKSUM=`md5sum ${ARCHIVE_FILE} 2>/dev/null |awk '{print $1;}'`
    elif test "${CHECKSUM_TYPE}" = "SHA256"; then
        CHECKSUM=`sha256sum ${ARCHIVE_FILE} 2>/dev/null |awk '{print $1;}'`
    elif test "${CHECKSUM_TYPE}" = "SHA1"; then
        CHECKSUM=`sha1sum ${ARCHIVE_FILE} 2>/dev/null |awk '{print $1;}'`
    else
        echo "ERROR: unknown checksum type: ${CHECKSUM_TYPE}"
        exit 1
    fi
    if test "${CHECKSUM_VALUE}" = "${CHECKSUM}"; then
        echo "Good checksum"
        exit 0
    else
        echo "Bad checksum ${CHECKSUM_VALUE} != ${CHECKSUM}"
        exit 2
    fi
fi 
