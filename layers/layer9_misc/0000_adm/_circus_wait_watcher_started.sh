#!/bin/bash

WATCHER=$1

echo -n "- Waiting for start of ${WATCHER}..."
echo_running

I=0
while test ${I} -lt 10; do
    circus_status_watcher.sh "${WATCHER}" >/dev/null 2>&1
    if test $? -eq 0; then
        break
    fi
    I=$((I + 1))
    sleep 1
done

if test "${I}" -ge 10; then
    echo_nok
    exit 1
else
    echo_ok
    exit 0
fi
