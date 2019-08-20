#!/bin/bash

function usage() {
    echo "usage: external_rpm_dependencies.sh"
    echo "  => execute this is a directory and it will try to find all "
    echo "     external (not metwork) rpm dependencies (with ldd and rpm -qf)"
}

if test "${1:-}" = "--help"; then
    usage
    exit 0
fi

DEPS=$(external_dependencies.sh)
( for DEP in ${DEPS}; do
    rpm -qf --qf "%{name}\n" "${DEP}"
done ) |sort |uniq
