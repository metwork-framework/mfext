#!/bin/bash

set -eu
set -x

cd /src


    yum -y localinstall ./rpms/metwork-mfext*.rpm
    yum -y install diffutils
    if test -d "integration_tests"; then cd integration_tests; /opt/metwork-mfext/bin/mfext_wrapper ./run_integration_tests.sh; cd ..; fi
