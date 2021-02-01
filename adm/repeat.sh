#!/bin/bash

function usage() {
    echo "usage: repeat.sh COMMAND [COMMAND_ARG1] [COMMAND_ARG2] [...]"
    echo "  => repeat command (with a 1s pause) until command exit code is zero"
}

function rkill() {
    if test "${PID:-}" != ""; then
        recursive_kill.py "${PID}"
        exit 1
    fi
}

if test "${1:-}" = ""; then
    usage
    exit 1
fi
if test "${1:-}" = "--"; then
    shift
    if test "${1:-}" = ""; then
        usage
        exit 1
    fi
fi
PID=
trap rkill SIGTERM
trap rkill SIGINT

while test 1 -eq 1; do

    # shellcheck disable=SC2068
    $@ &
    PID=$!
    if test "${PID}" != ""; then
        wait ${PID}
        if test $? -eq 0; then
            exit 0
        fi
    fi
    sleep 1

done
