#!/bin/bash

function standard_vimdiff() {
    exec vimdiff "$@"
}

if test "${METWORK_PYTHON_MODE:-}" = ""; then
    standard_vimdiff "$@"
    exit $?
fi

DEVTOOLS_LAYER=python${METWORK_PYTHON_MODE}_devtools@mfext
IS_DEVTOOLS_LAYER_INSTALLED=$(is_layer_installed "${DEVTOOLS_LAYER}")
if test "${IS_DEVTOOLS_LAYER_INSTALLED}" = "1"; then
    exec layer_wrapper --layers="${DEVTOOLS_LAYER}" -- "${MFEXT_HOME}/opt/python${METWORK_PYTHON_MODE}_devtools/bin/vimdiff" -u "${MFEXT_HOME}/opt/devtools/config/vimrc" "$@"
else
    standard_vimdiff "$@"
    exit $?
fi
