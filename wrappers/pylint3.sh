#!/bin/bash

if test "${1:-}" == "--help"; then
    echo "usage: pylint3.sh [PYLINT_ARG1] [PYLINT_ARG2] [...]"
    echo "  => execute pylint command with given args in a python3 env"
    echo "     (even if we are currently in python2 mode)"
    exit 0
fi
export METWORK_PYTHON_MODE=3
layer_wrapper --layers=python@mfext,-python@mfcom,-python@"${MODULE_LOWERCASE}" -- pylint "$@"
