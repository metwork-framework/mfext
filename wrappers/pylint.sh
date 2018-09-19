#!/bin/bash

if test "${METWORK_PYTHON_MODE:-}" = "2"; then
    exec pylint2.sh $@
else
    exec pylint3.sh $@
fi
