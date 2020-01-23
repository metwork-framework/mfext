#!/bin/bash

function usage() {
    echo "usage: _no_automatic_kill.sh COMMAND [COMMAND_ARG1] [COMMAND_ARG2] [...]"
    echo "  => wrapper to launch the COMMAND out of the metwork daemons list"
    echo "     so it can't be killed during module shutdown"
}

if test "${1:-}" = ""; then
    usage
    exit 1
fi
if test "${1:-}" = "--help"; then
    usage
    exit 0
fi

export METWORK_LIST_PROCESSES_FORCE=0
# shellcheck disable=SC2068
exec $@
