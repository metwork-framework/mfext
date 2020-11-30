#!/bin/bash

# We override with system wide custom settings (if existing)
if test -f /etc/metwork.custom_profile; then
    # shellcheck disable=SC1091
    . /etc/metwork.custom_profile
fi

. {{MFMODULE_HOME}}/share/profile

# We override with module wide custom settings (if existing)
if test -f ~/.metwork.custom_profile; then
    . ~/.metwork.custom_profile
fi

<<<<<<< HEAD
export NOINTERACTIVE=1
layer_wrapper --layers=python3@mfext -- cronwrap.py "$@"
=======
for P in /sbin /usr/sbin /usr/local/sbin; do
    if test -d "${P}"; then
        PATH=${PATH}:${P}
    fi
done
export PATH=${PATH}

# shellcheck disable=SC2068
exec cronwrap.py $@
>>>>>>> b7bd2d72... fix: fix an issue with < 1024 port binding (#999)
