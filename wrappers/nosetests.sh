#!/bin/bash

if test "${METWORK_PYTHON_MODE:-}" = "2"; then
    exec nosetests2.sh $@
else
    exec nosetests3.sh $@
fi
