#!/bin/bash

function usage() {
    echo "usage: _doc_layer.sh LAYER_NAME"
}

if test "${1:-}" = ""; then
    usage
    exit 1
fi
if test "${1:-}" = "--help"; then
    usage
    exit 0
fi
export LAYER_NAME=${1}

if test "${LAYER_NAME}" = "root"; then
    touch packages.md
else
    layer_wrapper --layers=python3_devtools@mfext -- "${MFEXT_HOME}/bin/_yaml_to_md.py" "${MFMODULE_HOME}/opt/${LAYER_NAME}" >packages.md
    if test $? -ne 0; then
        echo "ERROR DURING layer_wrapper --layers=python3_devtools@mfext -- ${MFEXT_HOME}/bin/_yaml_to_md.py ${MFMODULE_HOME}/opt/${LAYER_NAME}"
        exit 1
    fi
fi

DEPENDENCIES=$(cat .layerapi2_dependencies 2>/dev/null |paste -s -d, -)
CONFLICTS=$(cat .layerapi2_conflicts 2>/dev/null |paste -s -d, -)
LABEL=$(cat .layerapi2_label 2>/dev/null)
EXTRA_ENV=$(cat .layerapi2_extra_env 2>/dev/null)
EXTRA_PROFILE=$(cat .layerapi2_interactive_profile 2>/dev/null)
EXTRA_UNPROFILE=$(cat .layerapi2_interactive_unprofile 2>/dev/null)
SYSTEM_DEPENDENCIES=$(cat .system_dependencies 2>/dev/null |grep '@generic' |awk -F '@' '{print $1;}' |paste -s -d~ -)
PACKAGE=$(layer_wrapper --layers=python3_devtools@mfext -- _packaging_get_package_name "${LABEL}" 2>&1)
export DEPENDENCIES CONFLICTS LABEL EXTRA_ENV EXTRA_PROFILE EXTRA_UNPROFILE SYSTEM_DEPENDENCIES PACKAGE
export PACKAGES=
if test -s packages.md; then
    export PACKAGES=1
fi

echo
echo "[comment]: # (Generated file from template, DO NOT EDIT THIS FILE DIRECTLY)"
echo

CUSTOM=""
# FIXME: this name/location is deprecated
if test -f layer_custom.md; then
    CUSTOM=layer_custom.md
else
    if test -f doc/layer_root_custom.md; then
        CUSTOM=doc/layer_root_custom.md
    fi
fi

if test "${CUSTOM}" != ""; then \
    cat "${CUSTOM}" |envtpl --reduce-multi-blank-lines -i "${MFEXT_HOME}/share/templates,."
    if test $? -ne 0; then
        echo "ERROR during generation"
        exit 1
    fi
else \
    cat "${MFEXT_HOME}/share/templates/layer.md" |envtpl --reduce-multi-blank-lines -i "${MFEXT_HOME}/share/templates,."
    if test $? -ne 0; then
        echo "ERROR during generation"
        exit 1
    fi
fi
rm -f packages.md
