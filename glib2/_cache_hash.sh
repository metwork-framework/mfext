#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
git ls-tree "${BRANCH}" bootstrap.sh adm Makefile glib2 config layers/layer7_devtools/0000_penvtpl
cat "${DIR}/../adm/root.mk" |grep -v "_VERSION" |sort
rpm -qa |sort
