#!/bin/bash

function usage() {
    echo "usage: _cache_path.sh LABEL SOURCE_DIR LAYER_LABEL [IGNORE_SELF]"
}
function echoerr() {
    echo "$@" 1>&2;
}

if test "${3}" = ""; then
    usage
    exit 1
fi
if test "${1}" = "--help"; then
    usage
    exit 0
fi

if test "${BUILDCACHE:-}" = ""; then
    echo null
    exit 0
fi
if ! test -d "${BUILDCACHE}"; then
    echo null
    exit 0
fi
LABEL=$1
LAYER_LABEL="${3}"
export LC_ALL=C
if test "${4:-}" = "IGNORE_SELF"; then
    IGNORE_SELF="IGNORE_SELF"
else
    IGNORE_SELF=""
fi

if test "${SRC_DIR}" != ""; then
    DIR="${SRC_DIR}/adm"
else
    echo "ERROR: SRC_DIR env is not set"
    exit 1
fi

H0=""
if test -f /etc/buildimage_hash; then
    H0=$(cat /etc/buildimage_hash)
    echoerr "/etc/buildimage_hash: ${H0}"
fi

H1=$(cat "${DIR}/root.mk" |grep -v "_VERSION" |sort |md5sum |awk '{print $1;}')
echoerr "${DIR}/root.mk md5sum hash: ${H1}"

LH=$(layer_hash "${LAYER_LABEL}" "${IGNORE_SELF}")

SH=$( (git ls-files "${2}" |sort |xargs -n1 md5sum) |md5sum |awk '{print $1;}')
echoerr "source hash: ${SH}"

H=$(echo "${H0}_${H1}_${LH}_${SH}" |md5sum |awk '{print $1;}')
echo "${BUILDCACHE}/${MFMODULE_LOWERCASE}_cache_${LABEL}_${H}.tar"
