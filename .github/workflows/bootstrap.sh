#!/bin/bash

set -x
set -eu

cd /src
ls
mkdir -p "/opt/metwork-${MFMODULE_LOWERCASE}-${TARGET_DIR}"
./bootstrap.sh "/opt/metwork-${MFMODULE_LOWERCASE}-${TARGET_DIR}"
cat adm/root.mk
