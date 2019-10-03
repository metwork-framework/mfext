#!/bin/bash

echo -n "- Checking redis status..."
echo_running

if ! test -S "${MFMODULE_RUNTIME_HOME}/var/redis.socket"; then
    echo_nok
    exit 1
fi

OUTPUT=$(timeout 10s redis-cli -s "${MFMODULE_RUNTIME_HOME}/var/redis.socket" PING 2>/dev/null)
if test "${OUTPUT}" = "PONG"; then  
    echo_ok
    exit 0
else
    echo_nok
    exit 1
fi
