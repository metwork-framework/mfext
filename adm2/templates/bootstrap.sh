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

mkdir -p "${MODULE_HOME}/share"
{% if MODULE == "MFEXT" %}
    echo "Bootstrapping root and core layers..."
    "layerapi2/bootstrap_layer.sh" root@mfext "${MODULE_HOME}"
    REMOVE_CORE=0
    if ! test -d "${MODULE_HOME}/opt/core"; then
        REMOVE_CORE=1
        "layerapi2/bootstrap_layer.sh" core@mfext "${MODULE_HOME}/opt/core"
    fi
    echo "Building glib2 lib..."
    cd glib2 && make && cd ..
    echo "Building layerapi2 lib..."
    echo "export MODULE := MFEXT" >>adm/root.mk
    echo "export MODULE_LOWERCASE := mfext" >>adm/root.mk
    echo "export PATH := ${MFEXT_HOME}/bin:${PATH:-}" >>adm/root.mk
    ROOT_PATH=${MFEXT_HOME}/bin:${PATH:-}
    echo "export LD_LIBRARY_PATH := ${MFEXT_HOME}/lib:${LD_LIBRARY_PATH:-}" >>adm/root.mk
    echo "export PKG_CONFIG_PATH := ${MFEXT_HOME}/lib/pkgconfig:${PKG_CONFIG_PATH:-}" >>adm/root.mk
    echo "export MFEXT_HOME := ${MFEXT_HOME}" >>adm/root.mk
    echo "export MFEXT_VERSION := ${MFEXT_VERSION}" >>adm/root.mk
    echo "export MODULE_HOME := ${MFEXT_HOME}" >>adm/root.mk
    echo "export MODULE_VERSION := ${MFEXT_VERSION}" >>adm/root.mk
    cd adm && cp -f subdir_root.mk "${MFEXT_HOME}/share" && cd ..
    cd layerapi2 && make && cd ..
    rm -f adm/root.mk
    touch adm/root.mk
    cp -f adm/bash_utils.sh "${MFEXT_HOME}/lib"
    cp -f adm/envtpl "${MFEXT_HOME}/bin"
    cp -f adm/_make_file_from_template.sh "${MFEXT_HOME}/bin/"
{% else %}
echo "Bootstrapping root layers..."
"${MFEXT_HOME}/bin/bootstrap_layer.sh" "root@${MODULE_LOWERCASE}" "${MODULE_HOME}"
{% endif %}

echo "Building profile..."
cd adm && make "${MODULE_HOME}/share/profile" && cd ..

set +eu # FIXME
export METWORK_BOOTSTRAP_MODE=1
echo "Loading profile..."
# shellcheck disable=SC1090
source "${MODULE_HOME}/share/profile"
unset METWORK_BOOTSTRAP_MODE
set -eu # FIXME

echo "Making adm/root.mk..."
rm -f adm/root.mk
touch adm/root.mk
{% if MODULE != "MFEXT" and MODULE != "MFCOM" %}
echo "unexport MODULE_RUNTIME_HOME" >>adm/root.mk
echo "unexport MODULE_RUNTIME_SUFFIX" >>adm/root.mk
echo "unexport MODULE_RUNTIME_USER" >>adm/root.mk
{% endif %}echo "export MODULE := ${MODULE}" >>adm/root.mk
echo "export MODULE_LOWERCASE := $(echo ${MODULE} | tr '[:upper:]' '[:lower:]')" >>adm/root.mk
echo "export PATH := ${PATH}" >>adm/root.mk
echo "export METWORK_LAYERS_PATH := ${METWORK_LAYERS_PATH}" >>adm/root.mk
echo "export MFEXT_HOME := ${MFEXT_HOME}" >>adm/root.mk
echo "export MFEXT_VERSION := ${MFEXT_VERSION}" >>adm/root.mk
echo "export MODULE_HOME := ${MODULE_HOME}" >>adm/root.mk
echo "export MODULE_VERSION := {% raw %}${{% endraw %}{{MODULE}}{% raw %}_VERSION}{% endraw %}" >>adm/root.mk
echo "ifeq (\$(FORCED_PATHS),)" >>adm/root.mk
echo "  export PATH := ${ROOT_PATH}" >>adm/root.mk
echo "export LD_LIBRARY_PATH := ${MFEXT_HOME}/lib" >>adm/root.mk
echo "export PKG_CONFIG_PATH := ${MFEXT_HOME}/lib/pkgconfig" >>adm/root.mk
echo "endif" >>adm/root.mk
#echo "unexport PYTHON" >>adm/root.mk
#echo "unexport PYTHONPATH" >>adm/root.mk
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
    echo "export PREFIX := ${MODULE_HOME}" >>adm/root.mk
{% endif %}
echo "export PYTHON2_SHORT_VERSION := ${PYTHON2_SHORT_VERSION}" >>adm/root.mk
echo "export PYTHON3_SHORT_VERSION := ${PYTHON3_SHORT_VERSION}" >>adm/root.mk
echo "export SRC_DIR := ${SRC_DIR}" >>adm/root.mk

#echo "LAYER_ENVS:=\$(shell env |grep '^METWORK_LAYER_.*_LOADED=1\$\$' |awk -F '=' '{print \$\$1;}')" >>adm/root.mk
#echo "\$(foreach LAYER_ENV, \$(LAYER_ENVS), \$(eval unexport \$(LAYER_ENV)))" >>adm/root.mk

{% if MODULE == "MFEXT" %}
    if test "${REMOVE_CORE:-}" = "1"; then
        rm -Rf "${MODULE_HOME}/opt/core"
    fi
{% endif %}

echo "BOOTSTRAP DONE !"
echo "MFEXT_HOME=${MFEXT_HOME}"
{% if MODULE != "MFEXT" %}
    echo "MFCOM_HOME=${MFCOM_HOME}"
{% endif %}
