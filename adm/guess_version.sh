#!/bin/bash

if test "$1" = "--help" -o "$1" = "-h"; then
    echo "Guess a version with git branch and git number of commits in this branch (a git checkout is needed)"
    echo "The git revision is also added"
    echo "usage: guess_version.sh"
    exit 0
fi

BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null |sed 's/-/_/g')
if test "${BRANCH}" = ""; then
    BRANCH=unknown
fi

NUMBER_OF_COMMITS=$(git rev-list HEAD 2>/dev/null |wc -l)
COMMIT=$(git rev-parse --short HEAD 2>/dev/null)
if test "${COMMIT}" = ""; then
    COMMIT=unknown
fi

echo "${BRANCH}.${NUMBER_OF_COMMITS}.${COMMIT}"
exit 0
