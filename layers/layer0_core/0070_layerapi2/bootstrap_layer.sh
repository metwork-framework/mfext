#!/bin/bash

function usage()
{
    echo "usage: bootstrap_layer.sh LAYER_LABEL LAYER_HOME"
    echo "  => bootstrap a new layer in the given LAYER_HOME (directory path)"
    echo "     with the given LAYER_LABEL"
    echo "  => the directory is automatically created (if it does not exist)"
    echo "     and the .layerapi2_label file is created (if it does not exist)"
    echo "  => a bin/, lib/ and lib/pkgconfig/ subdirectories are also created"
    echo "  => if \${METWORK_PYTHON_MODE} environnement variable == 3,"
    echo  "      a lib/python\${PYTHON3_SHORT_VERSION}/site-packages is created"
}

if test "${1:-}" = "--help"; then
    usage
    exit 0
fi
if test "${1:-}" = ""; then
    usage
    exit 1
else
    export LAYER_LABEL="$1"
fi

if test "${2:-}" = ""; then
    usage
    exit 1
else
    export LAYER_HOME="$2"
fi

mkdir -p "${LAYER_HOME}/bin"
mkdir -p "${LAYER_HOME}/lib/pkgconfig"
mkdir -p "${LAYER_HOME}/lib/python${PYTHON3_SHORT_VERSION:-}/site-packages"
if ! test -f "${LAYER_HOME}/.layerapi2_label"; then
    echo "${LAYER_LABEL}" >"${LAYER_HOME}/.layerapi2_label"
fi
