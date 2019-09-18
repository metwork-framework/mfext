#!/bin/bash

. {{MFMODULE_HOME}}/share/profile

export NOINTERACTIVE=1

layer_wrapper --layers=python3@mfext -- cronwrap.py "$@"
