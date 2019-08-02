#!/bin/bash

# find external dependencies (system) with a dynamic link with metwork libs

cd "${MFEXT_HOME}" || exit 1
external_dependencies.sh >deps
RET=0
for F in $(cat deps); do
    N=$(ldd "${F}" 2>/dev/null |grep -c metwork)
    if test "$N" -gt 0; then
        echo "***** $F *****"
        echo "=== ldd |grep metwork ==="
        ldd "${F}" |grep metwork
        echo
        echo "=== revert ldd ==="
        revert_ldd.sh "${F}"
        echo
        echo
        RET=1
    fi
done

rm -f deps
if test "${RET}" = "1"; then
    echo "suspicious dependencies found"
    exit 1
fi
