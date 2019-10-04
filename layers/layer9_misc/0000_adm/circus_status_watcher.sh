#!/bin/bash

WATCHER=$1
if test "$2" != ""; then
    TITLE=$2
else
    TITLE=$1
fi
ENDPOINT=$(env |grep "^${MFMODULE}_CIRCUS_ENDPOINT" |awk -F '=' '{print $2;}')

echo -n "- Checking ${TITLE}..."
echo_running

# shellcheck disable=SC2001
SOCKET=$(echo "${ENDPOINT}" |sed 's~ipc://~~g')
if ! test -S "${SOCKET}"; then
    echo_nok
    exit 1
fi

S=$(timeout 10s _circusctl --endpoint "${ENDPOINT}" status "${WATCHER}" 2>/dev/null)
if test "${S}" = "active"; then
    echo_ok
    exit 0
else
    echo_nok
    exit 1
fi
