#!/bin/bash

if test "${METWORK_PYTHON_MODE:-}" = "2"; then
    exec flake82.sh $@
else
    exec flake83.sh $@
fi
