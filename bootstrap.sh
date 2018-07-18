#!/bin/bash

set -eu

function get_abs_filename() {
    echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

if test "${METWORK_PROFILE_LOADED:-0}" = "1"; then
    echo "ERROR: metwork environnement is already loaded"
    echo "=> use a terminal without metwork environnement loaded"
    echo "   to launch this script"
    exit 1
fi


    function usage() {
        echo "usage: ./bootstrap.sh INSTALL_PREFIX_DIRECTORY"
    }
    if test "${1:-}" = ""; then
        usage
        exit 1
    fi
    MFEXT_HOME=$(get_abs_filename "$1")
    export MFEXT_HOME
    MFEXT_VERSION=$(adm/guess_version.sh)
    export MFEXT_VERSION
    export MODULE_VERSION=${MFEXT_VERSION}


if test "${1:-}" = "--help"; then
    usage
    exit 1
fi

PREFIX=$(get_abs_filename "$1")
export PREFIX
if ! test -d "${PREFIX}"; then
    usage
    echo "ERROR: ${PREFIX} is not a directory"
    exit 1
fi
MFEXT_HOME=$(get_abs_filename "${MFEXT_HOME}")
export MFEXT_HOME



MODULE_HOME=$(get_abs_filename "${PREFIX}")
export MODULE_HOME
export MODULE=MFEXT
export MODULE_LOWERCASE=mfext
SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export SRC_DIR


rm -f adm/root.mk
touch adm/root.mk

ROOT_PATH=${MFEXT_HOME}/bin:${PATH:-}

echo "Making adm/root.mk..."
rm -f adm/root.mk
touch adm/root.mk
echo "export MODULE := ${MODULE}" >>adm/root.mk
echo "export MODULE_LOWERCASE := $(echo ${MODULE} | tr '[:upper:]' '[:lower:]')" >>adm/root.mk
echo "export METWORK_LAYERS_PATH := ${MFEXT_HOME}/opt:${MFEXT_HOME}" >>adm/root.mk
echo "export MFEXT_HOME := ${MFEXT_HOME}" >>adm/root.mk
echo "export MFEXT_VERSION := ${MFEXT_VERSION}" >>adm/root.mk
echo "export MODULE_HOME := ${MODULE_HOME}" >>adm/root.mk
echo "export MODULE_VERSION := ${MFEXT_VERSION}" >>adm/root.mk
echo "export SRC_DIR := ${SRC_DIR}" >>adm/root.mk
echo "ifeq (\$(FORCED_PATHS),)" >>adm/root.mk
echo "	export PATH := ${ROOT_PATH}" >>adm/root.mk
echo "	export LD_LIBRARY_PATH := ${MFEXT_HOME}/lib" >>adm/root.mk
echo "	export PKG_CONFIG_PATH := ${MFEXT_HOME}/lib/pkgconfig" >>adm/root.mk
echo "endif" >>adm/root.mk

# FIXME: do not hardcode this
# FIXME: move to layer root extra_env
echo "export PYTHON2_SHORT_VERSION := 2.7" >>adm/root.mk
echo "export PYTHON3_SHORT_VERSION := 3.5" >>adm/root.mk

echo "BOOTSTRAP DONE !"
echo "MFEXT_HOME=${MFEXT_HOME}"
