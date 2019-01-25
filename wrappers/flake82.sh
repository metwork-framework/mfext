#!/bin/bash

if test "${1:-}" == "--help"; then
    echo "usage: flake82.sh [FLAKE8_ARG1] [FLAGE8_ARG2] [...]"
    echo "  => execute flake8 command with given args in a python2 env"
    echo "     (even if we are currently in python3 mode)"
    echo "  => some documentation errors/hints are also ignored here"
    exit 0
fi
export METWORK_PYTHON_MODE=2
layer_wrapper --layers=python@mfext,-python@mfcom,-python@"${MODULE_LOWERCASE}" -- flake8 --ignore D101,D102,D103,D100,D104,D401,D413,D107,D200,D204,D210,D400,D105 "$@"
