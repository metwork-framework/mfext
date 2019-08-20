#!/bin/bash


OK_DEPS=$(cat list.txt |xargs)

N=$(cat /etc/redhat-release 2>/dev/null |grep -c "^CentOS release 6")
if test "${N}" -eq 0; then
    echo "We test this only on centos6"
    exit 0
fi

cd "${MODULE_HOME}" || exit 1
DEPS=$(external_dependencies.sh |sed 's/usr//g' |sed 's/lib64//g' |sed 's~/~~g' |xargs)

RET=0
for DEP in ${DEPS}; do
    FOUND=0
    for OK_DEP in ${OK_DEPS}; do
        if test "${DEP}" = "${OK_DEP}"; then
            FOUND=1
            break
        fi
    done
    if test "${FOUND}" = "1"; then
        continue
    fi
    echo "***** ${DEP} *****"
    echo "=== revert ldd ==="
    revert_ldd.sh "${DEP}"
    echo
    echo
    RET=1
done

if test "${RET}" = "1"; then
    echo "extra dependencies found"
    # FIXME: uncomment next line
    #exit 1
fi
