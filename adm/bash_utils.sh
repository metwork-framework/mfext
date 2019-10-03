#!/bin/bash

# FIXME: replace with a direct call to _field_prepend and drop this function
field_prepend() {
    local old_value
    old_value=$(eval echo "\$$1")
    local new_value
    new_value=$("${MFEXT_HOME}/opt/core/bin/_field_prepend" "${old_value}" "$2")
    eval export "\\$1=${new_value}"
}

# FIXME: replace with a direct call to _field_prepend and drop this function
field_remove() {
    local old_value
    old_value=$(eval echo "\$$1")
    local new_value
    new_value=$("${MFEXT_HOME}/opt/core/bin/_field_remove" --separator="${3:-':'}" "${old_value}" "$2")
    eval export "\\$1=${new_value}"
}

# FIXME: replace with a direct call to _field_prepend and drop this function
field_remove_with_wildcards() {
    local old_value
    old_value=$(eval echo "\$$1")
    local new_value
    new_value=$("${MFEXT_HOME}/opt/core/bin/_field_remove" --use-wildcards --separator="${3:-':'}" "${old_value}" "$2")
    eval export "\\$1=${new_value}"
}

exit_if_root() {
    if test "$(id -u)" -eq 0; then
        echo "can't run this program as root"
        exit 1
    fi
}

function cleanup_directories()
{
    if test "${MFMODULE_RUNTIME_HOME}" != ""; then
        for REP in tmp var log; do
        if test -d "${MFMODULE_RUNTIME_HOME}/${REP}"; then
            echo -n "- Cleaning ${MFMODULE_RUNTIME_HOME}/${REP}..."
            cd "${MFMODULE_RUNTIME_HOME}/${REP}" && rm -Rf ./* >/dev/null 2>&1
            echo_ok
        fi
        done
    fi
}
# FIXME: inline this function

function cleanup_pyc()
{
    if test "${MFMODULE_RUNTIME_HOME}" != ""; then
        find "${MFMODULE_RUNTIME_HOME}" -name "*.pyc" -delete
    fi
}
# FIXME: inline this function

function start_daemon() {
    if test $# -ne 3; then
        echo "ERROR : start_daemon() requires 3 arguments"
        exit 1
    fi
    # shellcheck disable=SC2086
    nohup $1 >>"$2" 2>>"$3" &
}
# FIXME: inline this function

function cache_get()
{
    FILE=${1}
    LIFETIME=${2}
    NEWERS="/etc/hosts /etc/resolv.conf /etc/nsswitch.conf /etc/metwork.config ${MFEXT_HOME}/opt/misc/config/config.ini ${MFMODULE_HOME}/config/config.ini ${MFMODULE_RUNTIME_HOME}/config/config.ini"
    if test -f "/etc/metwork.config.d/${MFMODULE_LOWERCASE}/config.ini"; then
        NEWERS="${NEWERS} /etc/metwork.config.d/${MFMODULE_LOWERCASE}/config.ini"
    fi
    OUT="find ${FILE} -type f -mmin -${LIFETIME} "
    for NEWER in ${NEWERS}; do
        if test -r "${NEWER}"; then
            OUT="${OUT} -newer ${NEWER}"
        fi
    done
    N=$(eval "${OUT}" 2>/dev/null |wc -l)
    if test "${N}" -gt 0; then
        cat "${FILE}" 2>/dev/null
    fi
}
# FIXME: replace with python

function cache_set_from_file()
{
    FILE=${1}
    FILE2=${2}
    lockfile -1 -l 20 "${FILE}.lock" >/dev/null 2>&1
    cp -f "${FILE2}" "${FILE}.tmp" >/dev/null 2>&1
    mv -f "${FILE}.tmp" "${FILE}"
    rm -f "${FILE}.lock"
}
# FIXME: replace with python

function which_or_empty()
{
    which --skip-alias --skip-functions "${1}" 2>/dev/null || echo
}

function layer_unload()
{
    local LAYER_UNLOAD_TMP
    LAYER_UNLOAD_TMP=$(mktemp)
    eval "$("${MFEXT_HOME}/opt/core/bin/layer_unload_bash_cmds" "--debug" "$@" 2>"${LAYER_UNLOAD_TMP}")"
    cat "${LAYER_UNLOAD_TMP}"
    rm -f "${LAYER_UNLOAD_TMP}"
}

function layer_load()
{
    local LAYER_LOAD_TMP
    LAYER_LOAD_TMP=$(mktemp)
    eval "$("${MFEXT_HOME}/opt/core/bin/layer_load_bash_cmds" "--debug" "$@" 2>"${LAYER_LOAD_TMP}")"
    cat "${LAYER_LOAD_TMP}"
    rm -f "${LAYER_LOAD_TMP}"
}

function layer_load_without_optional()
{
    local LAYER_LOAD_TMP
    LAYER_LOAD_TMP=$(mktemp)
    eval "$("${MFEXT_HOME}/opt/core/bin/layer_load_bash_cmds" "--debug" "--dont-load-optional" "$@" 2>"${LAYER_LOAD_TMP}")"
    cat "${LAYER_LOAD_TMP}"
    rm -f "${LAYER_LOAD_TMP}"
}

function is_layer_installed_or_exit()
{
    local N
    N=$(is_layer_installed "$1")
    if test "${N}" = "0"; then
        echo "ERROR: layer $1 is not installed => exit"
        exit 1
    fi
}
