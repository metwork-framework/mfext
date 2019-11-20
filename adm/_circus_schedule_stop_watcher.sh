#!/bin/bash

WATCHER=$1
ENDPOINT=$(env |grep "^${MFMODULE}_CIRCUS_ENDPOINT" |awk -F '=' '{print $2;}')

echo -n "- Scheduling stop of ${WATCHER}..."
echo_running

circus_status_watcher.sh "${WATCHER}" >/dev/null 2>&1
if test $? -ne 0; then
    echo_warning "(already stopped)"
    exit 0
fi

timeout 10s _circusctl --endpoint "${ENDPOINT}" stop "${WATCHER}" >/dev/null 2>/dev/null

echo_ok
exit 0
