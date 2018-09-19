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

{% if MODULE == "MFCOM" %}
    function usage() {
        echo "usage: ./bootstrap.sh INSTALL_PREFIX_DIRECTORY MFEXT_INSTALL_ROOT_DIRECTORY"
    }
    if test "${1:-}" = "" -o "${2:-}" = ""; then
        usage
        exit 1
    fi
    MFEXT_HOME=$(get_abs_filename "$2")
    export MFEXT_HOME
    if ! test -d "${MFEXT_HOME}"; then
        usage
        echo "ERROR: ${MFEXT_HOME} is not a directory"
        exit 1
    fi
    MFCOM_HOME=$(get_abs_filename "$1")
    export MFCOM_HOME
    MFCOM_VERSION=$("${MFEXT_HOME}/bin/guess_version.sh")
    export MFCOM_VERSION
    MFEXT_VERSION=$(cat "${MFEXT_HOME}/config/version")
    export MFEXT_VERSION
    export MODULE_VERSION=${MFCOM_VERSION}
{% elif MODULE == "MFEXT" %}
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
{% else %}
    function usage() {
        echo "usage: ./bootstrap.sh INSTALL_PREFIX_DIRECTORY MFCOM_INSTALL_ROOT_DIRECTORY"
    }
    if test "${1:-}" = "" -o "${2:-}" = ""; then
        usage
        exit 1
    fi
    if test "${1:-}" = ""; then
        usage
        exit 1
    fi
    MFCOM_HOME=$(get_abs_filename "$2")
    export MFCOM_HOME
    if ! test -d "${MFCOM_HOME}"; then
        usage
        echo "ERROR: ${MFCOM_HOME} is not a directory"
        exit 1
    fi
    if ! test -r "${MFCOM_HOME}/share/mfext_home"; then
        echo "ERROR: can't find mfext_home inside mfcom"
        exit 1
    fi
    MFEXT_HOME=$(cat "${MFCOM_HOME}/share/mfext_home")
    if ! test -d "${MFEXT_HOME}"; then
        echo "ERROR: ${MFEXT_HOME} is not a directory"
        exit 1
    fi
    export MFEXT_HOME
    MFEXT_VERSION=$(cat "${MFEXT_HOME}/config/version")
    export MFEXT_VERSION
    MFCOM_VERSION=$(cat "${MFCOM_HOME}/config/version")
    export MFCOM_VERSION
    {{MODULE}}_VERSION=$("${MFEXT_HOME}/bin/guess_version.sh")
    export {{MODULE}}_VERSION
    MODULE_VERSION=$("${MFEXT_HOME}/bin/guess_version.sh")
    export MODULE_VERSION
{% endif %}

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
{% if MODULE != "MFEXT" %}
    if ! test -f "${MFEXT_HOME}/bin/guess_version.sh"; then
        echo "ERROR: configured mfext home (${MFEXT_HOME}) is not a mfext home"
        exit 1
    fi
{% endif %}
{% if MODULE != "MFEXT" and MODULE != "MFCOM" %}
    MFCOM_HOME=$(get_abs_filename "${MFCOM_HOME}")
    export MFCOM_HOME
    if ! test -f "${MFCOM_HOME}/bin/echo_ok"; then
        echo "ERROR: configured mfcom home (${MFCOM_HOME}) is not a mfcom home"
        exit 1
    fi
{% endif %}

MODULE_HOME=$(get_abs_filename "${PREFIX}")
export MODULE_HOME
export MODULE={{MODULE}}
export MODULE_LOWERCASE={{MODULE_LOWERCASE}}
SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export SRC_DIR
{% if MODULE != "MFEXT" %}
    {% if MODULE != "MFCOM" %}
        export MODULE_HAS_HOME_DIR=1
    {% endif %}
{% endif %}

rm -f adm/root.mk
touch adm/root.mk

{% if MODULE == "MFEXT" %}
ROOT_PATH=${MFEXT_HOME}/bin:${PATH:-}
ROOT_LD_LIBRARY_PATH=${MFEXT_HOME}/lib
ROOT_PKG_CONFIG_PATH=${MFEXT_HOME}/lib/pkgconfig
ROOT_METWORK_LAYERS_PATH=${MFEXT_HOME}/opt:${MFEXT_HOME}
{% elif MODULE == "MFCOM" %}
ROOT_PATH=${MFCOM_HOME}/bin:${MFEXT_HOME}/bin:${PATH:-}
ROOT_LD_LIBRARY_PATH=${MFCOM_HOME}/lib:${MFEXT_HOME}/lib
ROOT_PKG_CONFIG_PATH=${MFCOM_HOME}/lib/pkgconfig:${MFEXT_HOME}/lib/pkgconfig
ROOT_METWORK_LAYERS_PATH=${MFCOM_HOME}/opt:${MFCOM_HOME}:${MFEXT_HOME}/opt:${MFEXT_HOME}
{% else %}
ROOT_PATH=${MODULE_HOME}/bin:${MFCOM_HOME}/bin:${MFEXT_HOME}/bin:${PATH:-}
ROOT_LD_LIBRARY_PATH=${MODULE_HOME}/lib:${MFCOM_HOME}/lib:${MFEXT_HOME}/lib
ROOT_PKG_CONFIG_PATH=${MODULE_HOME}/lib/pkgconfig:${MFCOM_HOME}/lib/pkgconfig:${MFEXT_HOME}/lib/pkgconfig
ROOT_METWORK_LAYERS_PATH=${MODULE_HOME}/opt:${MODULE_HOME}:${MFCOM_HOME}/opt:${MFCOM_HOME}:${MFEXT_HOME}/opt:${MFEXT_HOME}
{% endif %}

echo "Making adm/root.mk..."
rm -f adm/root.mk
touch adm/root.mk
{% if MODULE != "MFEXT" and MODULE != "MFCOM" %}
echo "unexport MODULE_RUNTIME_HOME" >>adm/root.mk
echo "unexport MODULE_RUNTIME_SUFFIX" >>adm/root.mk
echo "unexport MODULE_RUNTIME_USER" >>adm/root.mk
{% endif %}
echo "export MODULE := ${MODULE}" >>adm/root.mk
echo "export MODULE_LOWERCASE := $(echo ${MODULE} | tr '[:upper:]' '[:lower:]')" >>adm/root.mk
echo "export METWORK_LAYERS_PATH := ${ROOT_METWORK_LAYERS_PATH}" >>adm/root.mk
echo "export MFEXT_HOME := ${MFEXT_HOME}" >>adm/root.mk
echo "export MFEXT_VERSION := ${MFEXT_VERSION}" >>adm/root.mk
echo "export MODULE_HOME := ${MODULE_HOME}" >>adm/root.mk
echo "export MODULE_VERSION := {% raw %}${{% endraw %}{{MODULE}}{% raw %}_VERSION}{% endraw %}" >>adm/root.mk
echo "export SRC_DIR := ${SRC_DIR}" >>adm/root.mk
echo "ifeq (\$(FORCED_PATHS),)" >>adm/root.mk
echo "  export PATH := ${ROOT_PATH}" >>adm/root.mk
echo "  export LD_LIBRARY_PATH := ${ROOT_LD_LIBRARY_PATH}" >>adm/root.mk
echo "  export PKG_CONFIG_PATH := ${ROOT_PKG_CONFIG_PATH}/lib/pkgconfig" >>adm/root.mk
echo "  LAYER_ENVS:=\$(shell env |grep '^METWORK_LAYER_.*_LOADED=1\$\$' |awk -F '=' '{print \$\$1;}')" >>adm/root.mk
echo "  \$(foreach LAYER_ENV, \$(LAYER_ENVS), \$(eval unexport \$(LAYER_ENV)))" >>adm/root.mk
echo "endif" >>adm/root.mk
{% if MODULE != "MFEXT" %}
        echo "export MFCOM_HOME := ${MFCOM_HOME}" >>adm/root.mk
        echo "export MFCOM_VERSION := ${MFCOM_VERSION}" >>adm/root.mk
        {% if MODULE != "MFCOM" %}
            echo "export ${MODULE}_HOME := ${MODULE_HOME}" >>adm/root.mk
            echo "export ${MODULE}_VERSION := {% raw %}${{% endraw %}{{MODULE}}{% raw %}_VERSION}{% endraw %}" >>adm/root.mk
        {% endif %}
    if test "${MODULE_HAS_HOME_DIR:-}" = "1"; then
    echo "export MODULE_HAS_HOME_DIR := 1" >>adm/root.mk
    fi
    #echo "export PREFIX := ${MODULE_HOME}" >>adm/root.mk
{% endif %}

# FIXME: do not hardcode this
# FIXME: move to layer root extra_env ?
echo "export PYTHON2_SHORT_VERSION := 2.7" >>adm/root.mk
echo "export PYTHON3_SHORT_VERSION := 3.5" >>adm/root.mk

echo "BOOTSTRAP DONE !"
echo "MFEXT_HOME=${MFEXT_HOME}"
{% if MODULE != "MFEXT" %}
    echo "MFCOM_HOME=${MFCOM_HOME}"
{% endif %}
