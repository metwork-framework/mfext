#!/bin/bash

# FIXME: fix to ensure compatibility with existing plugins using
# old variables names MODULE* (to be removed)
for var in MODULE MODULE_HOME MODULE_LOWERCASE MODULE_VERSION MODULE_STATUS MODULE_RUNTIME_HOME MODULE_RUNTIME_USER MODULE_RUNTIME_SUFFIX MODULE_PLUGINS_BASE_DIR; do
    new_var="MF${var}"
    if test "${!var}" = ""; then
        eval "export ${var}=\"${!new_var}\""
    fi
done

set -eu

if ! test -s "${MFMODULE_HOME}/config/crontab"; then
    exit 0
fi

RUNTIME_SUFFIX=""
if test "${MFMODULE_RUNTIME_SUFFIX:-}" != ""; then
    RUNTIME_SUFFIX="export MFMODULE_RUNTIME_SUFFIX=${MFMODULE_RUNTIME_SUFFIX} ; "
fi
export RUNTIME_SUFFIX

cat "${MFMODULE_HOME}/config/crontab" |envtpl --reduce-multi-blank-lines

if test -d "${MFMODULE_RUNTIME_HOME}/var/plugins"; then
    for TMP in $(plugins.list --raw); do
        BDIR=$(echo "${TMP}" |awk -F '~~~' '{print $4;}')
        NAME=$(echo "${TMP}" |awk -F '~~~' '{print $1;}')
        if test -s "${BDIR}/crontab"; then
            echo "##### BEGINNING OF METWORK ${MFMODULE} PLUGIN ${NAME} CRONTAB #####"
            cat "${BDIR}/crontab" | envtpl --reduce-multi-blank-lines
            echo "##### END OF METWORK ${MFMODULE} PLUGIN ${NAME} CRONTAB #####"
        fi
    done
fi
