#!/bin/bash

set -eu

TEMPLATE_NAME="$1"
CUSTOM_SUFFIX="${2:-}"
if test "${3:-}" = "DONT_REDUCE"; then
    REDUCE=""
else
    REDUCE="--reduce-multi-blank-lines"
fi

ENVTPL="${MFEXT_HOME}/bin/envtpl ${REDUCE}"
if test -f "${TEMPLATE_NAME}${CUSTOM_SUFFIX}"; then
    cat "${TEMPLATE_NAME}${CUSTOM_SUFFIX}" |${ENVTPL} -i "${MFEXT_HOME}/share/templates"
else
    cat "${MFEXT_HOME}/share/templates/${TEMPLATE_NAME}" |${ENVTPL} -i "${MFEXT_HOME}/share/templates"
fi
