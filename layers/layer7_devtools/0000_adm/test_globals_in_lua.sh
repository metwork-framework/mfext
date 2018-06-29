#!/bin/bash

function usage() {
    echo "usage: test_globals_in_lua.sh LUA_FILE"
    echo " => test if there are some global variables in the given lua file"
    echo "    and exit with an error code if there are some."
    echo " => you can also provide a pattern like *.lua as argument"
    echo " => if no global variables are found in lua files, exit with 0 return"
    echo "    code"
}

if test "${1:-}" = "--help"; then
    usage
    exit 0
fi
if test "${1:-}" = ""; then
    usage
    exit 1
fi

N=$(lua-releng "$1" 2>/dev/null |grep -c ETGLOBAL)
if test "${N}" -gt 0; then
    lua-releng "$1"
    echo "ERROR: global var found => exiting"
    exit 1
fi
