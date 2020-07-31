#!/bin/bash

set -x
set -eu

cd /src
ls
mkdir -p "/opt/metwork-mfext-${TARGET_DIR}"
./bootstrap.sh "/opt/metwork-mfext-${TARGET_DIR}"
cat adm/root.mk
