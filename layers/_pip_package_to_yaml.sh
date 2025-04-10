#!/bin/bash

set -eu

function usage() {
    echo "usage: _pip_package_to_yaml.sh PACKAGE PATH_TO_METWORK_PACKAGES"
}

if test "${1:-}" = ""; then
    usage
    exit 1
fi
if test "${2:-}" = ""; then
    usage
    exit 1
fi

PACKAGE="$1"
N=$(echo "${PACKAGE}" |grep -c -e "^\\-e git+http" -e "^\\https" || true)
SOURCE=
if test "${N}" -gt 0; then
    # this is a link like
    # -e git+https://github.com/Hawker65/deploycron.git@8fc7c4b8b072d7be7fb27517c9640bd1846b2ed9#egg=deploycron
    # or
    # https://downloads.sourceforge.net/project/matplotlib/matplotlib-toolkits/basemap-1.0.7/basemap-1.0.7.tar.gz#egg=basemap
    SOURCE=$(echo "${PACKAGE}" |awk -F "#egg=" '{print $1;}' |sed 's/^-e //g')
    PACKAGE=$(echo "${PACKAGE}" |awk -F "#egg=" '{print $2;}')
    GIT_REF=$(echo "${SOURCE}" | awk -F "@" '{print $2;}')
    if test "${GIT_REF}" = ""; then
        GIT_REF=$(echo "${SOURCE}" | awk -F ".tar.gz" '{print $1;}' | awk -F "-" '{print $NF;}')
    fi
    if test "${PACKAGE}" = ""; then
        echo "can't find egg name in $2 => missing #egg=xxxxx part in the url ?"
        exit 1
    fi
else
    N=$(echo "${PACKAGE}" |grep -c "==" || true)
    if test "${N}" -gt 0; then
        PACKAGE=$(echo "${PACKAGE}" |awk -F '==' '{print $1;}')
    fi
fi

METWORK_PACKAGES="$2"
if ! test -d "${METWORK_PACKAGES}"; then
    echo "${METWORK_PACKAGES} is not a directory"
    usage
    exit 1
fi

TMPFILE="${TMPDIR:-/tmp}/pip_show.$$"
pip --disable-pip-version-check show "${PACKAGE}" >"${TMPFILE}"

NAME=$(cat "${TMPFILE}" |grep "^Name: " | head -1 | sed 's/^Name: //g')
VERSION=$(cat "${TMPFILE}" |grep "^Version: " | head -1 | sed 's/^Version: //g')
DESCRIPTION=$(cat "${TMPFILE}" |grep "^Summary: " | head -1 | sed 's/^Summary: //g')
WEBSITE=$(cat "${TMPFILE}" |grep "^Home-page: " | head -1 | sed 's/^Home-page: //g')
LICENSE=$(cat "${TMPFILE}" |grep "^License: " | head -1 | sed 's/^License: //g')

TARGET="${METWORK_PACKAGES}/${NAME}.yaml"

rm -f "${TARGET}"
touch "${TARGET}"

echo "name: ${NAME}" >>"${TARGET}"
if test "${SOURCE:-}" = ""; then
    echo "version: '${VERSION}'" >>"${TARGET}"
else
    if [[ ${GIT_REF} =~ ^([[:xdigit:]]){40}$ ]]; then
        # Probably a commit number ==> version = short commit number
        echo "version :" `echo ${GIT_REF} | cut -c 1-7` >>"${TARGET}"
    else
        # Probably a tag ==> version = tag
        echo "version: '${GIT_REF}'" >>"${TARGET}"
    fi
fi
echo "extension: 'wheel'" >>"${TARGET}"
echo "checktype: 'none'" >>"${TARGET}"
echo "checksum: 'none'" >>"${TARGET}"
echo -n "description: '" >>"${TARGET}"
echo -n "${DESCRIPTION}" |sed "s/'/ /g" >>"${TARGET}"
echo "'" >>"${TARGET}"
echo "website: '${WEBSITE}'" >>"${TARGET}"
echo "license: '${LICENSE}'" >>"${TARGET}"
echo "sources:" >>"${TARGET}"
if test "${SOURCE:-}" = ""; then
    echo "    - url: 'pypi://${NAME}/${VERSION}'" >>"${TARGET}"
else
    echo "    - url: '${SOURCE}'" >>"${TARGET}"
fi

echo "${TARGET} is ready"

rm -f "${TMPFILE}"
