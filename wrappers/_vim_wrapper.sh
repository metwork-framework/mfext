#!/bin/bash

function standard_vim() {
    which --skip-alias vim >/dev/null 2>&1
    if test $? -eq 0; then    
        exec vim "$@"
    else
        exec vi "$@"
    fi
}

if test "${METWORK_PYTHON_MODE:-}" = ""; then
    standard_vim "$@"
    exit $?
fi

DEVTOOLS_LAYER=python${METWORK_PYTHON_MODE}_devtools@mfext
IS_DEVTOOLS_LAYER_INSTALLED=$(is_layer_installed "${DEVTOOLS_LAYER}" 2>/dev/null)
if test "${IS_DEVTOOLS_LAYER_INSTALLED}" = "1"; then
    exec layer_wrapper --layers="${DEVTOOLS_LAYER}" -- "${MFEXT_HOME}/opt/python3_devtools/bin/vim" -u "${MFEXT_HOME}/opt/devtools/config/vimrc" "$@"
else
    standard_vim "$@"
    exit $?
fi
