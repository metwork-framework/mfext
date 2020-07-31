#!/bin/bash

set -x
set -eu

cd /src
MAKE_LOG="/pub/metwork/continuous_integration/buildlogs/${BRANCH}/mfext/${OS_VERSION}/${GITHUB_RUN_NUMBER}"
mkdir -p "${MAKE_LOG}"
make >"${MAKE_LOG}" 2>&1
