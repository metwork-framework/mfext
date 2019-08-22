#!/bin/bash

LAYERS=$(layers --raw |grep "@${MODULE_LOWERCASE} " |sed 's/ /|/g' |sort)

echo "# Full list of ${MODULE_LOWERCASE} components (by layer)"
echo

for TMP in ${LAYERS}; do
    LAYER_LABEL=$(echo "${TMP}" |awk -F '|' '{print $1;}')
    LAYER_DIR=$(echo "${TMP}" |awk -F '|' '{print $2;}')
    LAYER_NAME=$(echo "${LAYER_LABEL}" |awk -F '@' '{print $1;}')

    N=$(_packaging_get_module_dependencies 1 2 3 |grep -c "label....${LAYER_LABEL}")
    if test "${N}" -gt 0; then
        PACKAGE='`'"metwork-${MODULE_LOWERCASE}"'`'" (default)"
    else
        PACKAGE='`'"metwork-${MODULE_LOWERCASE}-layer-${LAYER_NAME}"'`'" (extra)"
    fi
    OUT=$(_yaml_to_md.py --not-sphinx "${LAYER_DIR}" 2>/dev/null)
    if test "${OUT}" = ""; then
        continue
    fi
    echo
    echo "## Layer: ${LAYER_NAME} (in package: ${PACKAGE})"
    echo
    echo "${OUT}"
done
