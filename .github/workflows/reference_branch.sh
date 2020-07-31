#!/bin/bash

# FIXME: tags ?
# FIXME: PRs ?

set -eu

if test "${OS_VERSION:-}" = ""; then
    echo "ERROR: OS_VERSION env is empty"
    exit 1
fi
if test "${MFMODULE_LOWERCASE:-}" = ""; then
    echo "ERROR: MFMODULE_LOWERCASE env is empty"
    exit 1
fi

B=${GITHUB_REF#refs/heads/}
case "${GITHUB_REF}" in
    refs/heads/experimental* | refs/heads/master | refs/heads/release_*)
        BRANCH=${B};;
    *)
        BRANCH=integration;;
esac

echo "::set-output name=name::${BRANCH}"
echo "::set-output name=buildimage::metwork/${MFMODULE_LOWERCASE}-${OS_VERSION}-buildimage:${BRANCH}"
