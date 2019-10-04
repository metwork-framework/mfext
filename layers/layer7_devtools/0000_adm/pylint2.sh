#!/bin/bash

if test "${1:-}" == "--help"; then
    echo "usage: pylint2.sh [PYLINT_ARG1] [PYLIN2_ARG2] [...]"
    echo "  => execute pylint command with given args in a python2 env"
    echo "     (even if we are currently in python3 mode)"
    exit 0
fi
export METWORK_PYTHON_MODE=2
layer_wrapper --layers=python2_devtools@mfext,-python2_misc@mfext,-python2@"${MODULE_LOWERCASE}" -- pylint "$@"

