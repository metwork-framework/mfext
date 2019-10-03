#!/bin/bash

set -eu

function usage() {
    echo "usage: remove_empty.sh => remove recursively empty dirs and files in the current working dir"
    echo "(up to 10 levels of recursion)"
}

if test "${1:-}" = "--help"; then
    usage
    exit 0
fi

# Remove empty files
find . -type f -empty -not -name "*.py" -delete

# Remove recursively empty dirs
RECURSION=0
while test ${RECURSION} -le 10; do
    N=$(find . -type d -empty |wc -l)
    if test "${N}" -gt 0; then
        find . -type d -empty -delete
    else
        break
    fi
    # shellcheck disable=SC2003
    RECURSION=$(expr ${RECURSION} + 1)
done
