#!/bin/bash

if test "$1" = "--help" -o "$1" = "-h"; then
    echo "Guess a version with git branch and git number of commits in this branch (a git checkout is needed)"
    echo "The git revision is also added"
    echo "usage: guess_version.sh"
    exit 0
fi

if test "${DRONE_BRANCH:-}" != ""; then
    _BRANCH=${DRONE_BRANCH}
else
    _BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null |sed 's/-/_/g')
fi
if [[ "${_BRANCH}" == release_* ]]; then
    # shellcheck disable=SC2001
    BRANCH=$(echo "${_BRANCH}" |sed 's/release_//g')
else
    if test "${_BRANCH}" = ""; then
        BRANCH=unknown
    else
        BRANCH="${_BRANCH}"
    fi
fi

if [[ "${_BRANCH}" == release_* ]]; then
    NUMBER_OF_COMMITS=$(git rev-list HEAD ^master 2>/dev/null |wc -l)
else
    NUMBER_OF_COMMITS=$(git rev-list HEAD 2>/dev/null |wc -l)
fi
COMMIT=$(git rev-parse --short HEAD 2>/dev/null)
if test "${COMMIT}" = ""; then
    COMMIT=unknown
fi

echo "${BRANCH}.${NUMBER_OF_COMMITS}.${COMMIT}"
exit 0
