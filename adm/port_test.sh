#!/bin/bash

function usage() {
    echo "usage: port_test.sh HOSTNAME PORT"
}

HOSTNAME=$1
PORT=$2

if test "${HOSTNAME}" = ""; then
    usage
    exit 1
fi

if test "${PORT}" = ""; then
    usage
    exit 1
fi

tcping -q -t 5 ${HOSTNAME} ${PORT} >/dev/null 2>&1
RES=$?

if test ${RES} -eq 0; then
    echo "ok"
else
    echo "nok"
fi

exit ${RES}
