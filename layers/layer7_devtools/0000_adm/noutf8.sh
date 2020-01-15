#!/bin/bash

if test "${1:-}" = "--help"; then
    echo "usage: noutf8.sh"
    echo "  => find utf8 (non ascii) characters in the current directory"
    echo "     (and exit 1 if we found some)"
    exit 0
fi

TMPFILE="/tmp/noutf8.$$"

rm -f "${TMPFILE}"
find . -type f -print0 |
    while IFS= read -r -d $'\0' line; do
        # shellcheck disable=SC1117,SC2126
        N=$(cat "${line}" |grep -P -n "[\x80-\xFF]" |wc -l)
        if test "${N}" -gt 0; then
            echo "ERROR: UTF8 found in ${line}:"
            # shellcheck disable=SC1117,SC2126
            cat "${line}" |grep --color -P -n "[\x80-\xFF]"
            touch "${TMPFILE}"
        fi
    done

if test -f "${TMPFILE}"; then
    rm -f "${TMPFILE}"
    exit 1
fi
exit 0
