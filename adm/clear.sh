#!/bin/bash

if test "$1" = "--help" -o "$1" = "-h"; then
    echo "clear wrapper (clear command does not work well for some terminal, force a xterm clear in this case)"
    echo "usage: clear.sh"
    exit 0
fi

clear
if test $? -ne 0; then
    OLD_TERM=${TERM}
    TERM=xterm
    clear
    TERM=${OLD_TERM}
fi
