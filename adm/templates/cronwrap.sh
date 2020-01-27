#!/bin/bash

# We override with system wide custom settings (if existing)
if test -f /etc/metwork.custom_profile; then
    # shellcheck disable=SC1091
    . /etc/metwork.custom_profile
fi

. {{MFMODULE_HOME}}/share/profile

<<<<<<< HEAD
export NOINTERACTIVE=1

layer_wrapper --layers=python3@mfext -- cronwrap.py "$@"
=======
# We override with module wide custom settings (if existing)
if test -f ~/.metwork.custom_profile; then
    . ~/.metwork.custom_profile
fi

# shellcheck disable=SC2068
exec cronwrap.py $@
>>>>>>> 7b1a393... feat: cronwrap load custom profiles like bashrc/profile
