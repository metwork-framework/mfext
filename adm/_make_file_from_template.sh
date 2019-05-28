#!/bin/bash

set -eu

TEMPLATE_NAME="$1"
CUSTOM_SUFFIX="${2:-}"

ENVTPL="${MFEXT_HOME}/bin/envtpl --reduce-multi-blank-lines"
if test -f "${TEMPLATE_NAME}${CUSTOM_SUFFIX}"; then
    cat "${TEMPLATE_NAME}${CUSTOM_SUFFIX}" |${ENVTPL} -i "${MFEXT_HOME}/share/templates"
else
    cat "${MFEXT_HOME}/share/templates/${TEMPLATE_NAME}" |${ENVTPL} -i "${MFEXT_HOME}/share/templates"
fi
