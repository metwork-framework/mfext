#!/bin/bash

if test "${1:-}" == "--help"; then
    echo "usage: nosetests2.sh [NOSETESTS_ARG1] [NOSETESTS_ARG2] [...]"
    echo "  => execute nosetests command with given args in a python2 env"
    echo "     (even if we are currently in python3 mode)"
    exit 0
fi
export METWORK_PYTHON_MODE=2
layer_wrapper --layers=python@mfext,-python@mfcom,-python@"${MODULE_LOWERCASE}" -- nosetests "$@"
