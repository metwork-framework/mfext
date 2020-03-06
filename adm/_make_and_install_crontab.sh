#!/bin/bash

echo -n "- Building crontab file..."
echo_running
_make_crontab.py >"${MFMODULE_RUNTIME_HOME}/tmp/config_auto/crontab" 2>"${MFMODULE_RUNTIME_HOME}/tmp/crontab_errors.$$"
if test $? -ne 0; then
    echo_nok
    echo_bold "ERROR: see ${MFMODULE_RUNTIME_HOME}/tmp/crontab_errors.$$ for details"
    exit 1
fi
if test -s "${MFMODULE_RUNTIME_HOME}/tmp/crontab_errors.$$"; then
    echo_warning
    cat "${MFMODULE_RUNTIME_HOME}/tmp/crontab_errors.$$"
else
    echo_ok
fi
rm -f "${MFMODULE_RUNTIME_HOME}/tmp/crontab_errors.$$"

echo -n "- Installing crontab file..."
echo_running

if hash crontab 2>/dev/null; then
    deploycron_file "${MFMODULE_RUNTIME_HOME}/tmp/config_auto/crontab" >"${MFMODULE_RUNTIME_HOME}/tmp/deploycron_errors.$$" 2>&1
    if test $? -eq 0; then
        echo_ok
        rm -f "${MFMODULE_RUNTIME_HOME}/tmp/deploycron_errors.$$"
    else
        echo_nok "(can't install)"
        echo_bold "ERROR: see ${MFMODULE_RUNTIME_HOME}/tmp/deploycron_errors.$$ for details"
        echo_bold "=> you probably have a bad crontab in a plugin, try to remove them"
        echo_bold "   one by one and relaunch _make_and_install_crontab.sh after each removal"
        echo_bold "   to find which one"
        exit 1
    fi
else
    echo_warning "(no crontab installed)"
fi
