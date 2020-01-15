#!/bin/bash

. {{MFMODULE_HOME}}/share/profile

# shellcheck disable=SC2068
exec cronwrap.py $@
