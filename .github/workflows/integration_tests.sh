#!/bin/bash

set -eu
set -x

cd /src


    yum -y localinstall ./rpms/metwork-mfext*.rpm
    yum -y install make

    if test -d "integration_tests"; then cd integration_tests; ./run_integration_tests.sh; cd ..; fi

