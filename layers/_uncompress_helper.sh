#!/bin/bash

ARCHIVE_FILE=$1
if ! test -f ${ARCHIVE_FILE}; then
    echo "ERROR: ${ARCHIVE_FILE} does not exist => exit"
    exit 1
fi
EXTENSION=$2
DIRNAME=$3
if test "${DIRNAME}" = ""; then
    DIRNAME=`basename ${ARCHIVE_FILE} |sed "s/\.${EXTENSION}//g"`
fi


OLDPWD=`pwd`
DIR=`dirname ${ARCHIVE_FILE}`
cd ${DIR} || exit 1
rm -Rf ${DIRNAME}
if test "${EXTENSION}" = "tar.gz"; then
    zcat ${ARCHIVE_FILE} |tar -xf -
elif test "${EXTENSION}" = "tar.bz2"; then
    bzip2 -dc ${ARCHIVE_FILE} |tar -xf -
elif test "${EXTENSION}" = "tgz"; then
    zcat ${ARCHIVE_FILE} |tar -xf -
elif test "${EXTENSION}" = "zip"; then
    unzip -o ${ARCHIVE_FILE}
elif test "${EXTENSION}" = "tar.xz"; then
    xz -dc ${ARCHIVE_FILE} |tar -xf -
elif test "${EXTENSION}" = "rpm"; then
    outside rpm2cpio ${ARCHIVE_FILE} | cpio -imd
else
    echo "ERROR: unknown extension [${EXTENSION}] => exit"
    exit 1
fi

PATCHES_FILE=`dirname ${ARCHIVE_FILE}`/../patches
if test -f ${PATCHES_FILE}; then
    for PATCH in `cat ${PATCHES_FILE} |grep -v '^#' |grep '[a-zA-Z0-9]'`; do
        echo "Patching with ${PATCH}..."
        cd ${DIR}/${DIRNAME} || exit 1
        patch -p1 <`dirname ${PATCHES_FILE}`/${PATCH}
        if test $? -ne 0; then
            echo "Bad patch result"
            exit 1
        fi
        echo "Patch ok"
    done
fi
