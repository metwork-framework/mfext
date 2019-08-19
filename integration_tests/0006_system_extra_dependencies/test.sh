#!/bin/bash


OK_DEPS="libbz2.so.1 libc.so.6 libcrypt.so.1 libdl.so.2 libfreebl3.so libgcc_s.so.1 libm.so.6 libncurses.so.5 libncursesw.so.5 libnsl.so.1 libnspr4.so libplc4.so libplds4.so libpopt.so.0 libpthread.so.0 libresolv.so.2 librt.so.1 libtinfo.so.5 libutil.so.1 libz.so.1 libelf.so.1 libmagic.so.1 libnss3.so libnssutil3.so libpanelw.so.5 libsmime3.so libssl3.so libstdc++.so.6"

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
