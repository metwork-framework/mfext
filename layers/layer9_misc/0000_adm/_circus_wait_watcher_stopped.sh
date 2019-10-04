#!/bin/bash

WATCHER=$1
ENDPOINT=$(env |grep "^${MFMODULE}_CIRCUS_ENDPOINT" |awk -F '=' '{print $2;}')
SOCKET=$(echo "${ENDPOINT}" |sed 's~ipc://~~g')
is_interactive
if test $? -eq 0; then
    IS_INTERACTIVE=1
else
    IS_INTERACTIVE=0
fi

echo -n "- Waiting for stop of ${WATCHER}..."
echo_running

I=0
SLOW=0
while test ${I} -lt 400; do
    # yes we schedule another time because sometimes circus returns a concurrency error
    _circus_schedule_stop_watcher.sh "${WATCHER}" >/dev/null 2>&1
    if ! test -S "${SOCKET}"; then
        break
    fi
    S=$(timeout 10s _circusctl --endpoint "${ENDPOINT}" status "${WATCHER}" 2>/dev/null)
    if test "${S}" = "stopped"; then
        break
    fi
    if test "${S}" = "error"; then
        break
    fi
    I=$(expr ${I} + 1)
    sleep 1
    if test "${IS_INTERACTIVE}" = "1"; then
        if test ${I} -gt 5; then
            if test "${SLOW}" = "0"; then
                echo_warning "(slow)"
                SLOW=1
            fi
            echo "    => waiting ${I}/400..."
            echo -en "\e[1A"
        fi
    fi
done

if test "${SLOW}" = "1"; then
    echo -en "\e[1A"
fi
if test "${I}" -ge 400; then
    echo_nok "           "
    exit 1
else
    echo_ok "           "
    exit 0
fi
