#!/bin/bash

if test "${1:-}" == "--help"; then
    echo "usage: nosetests.sh [NOSETESTS_ARG1] [NOSETESTS_ARG2] [...]"
    echo "  => execute nosetests command with given args in a python3 env"
    exit 0
fi
export METWORK_PYTHON_MODE=3
layer_wrapper --layers=python3_devtools@mfext,-python3@"${MODULE_LOWERCASE}" -- nosetests "$@"
