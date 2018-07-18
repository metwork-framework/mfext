#!/bin/bash

# see http://stackoverflow.com/questions/24515385/is-there-a-general-way-to-add-prepend-remove-paths-from-general-environment-vari
field_prepend() {
    local varName=$1 fieldVal=$2 IFS=${3:-':'} auxArr
    read -ra auxArr <<< "${!varName}"
    for i in "${!auxArr[@]}"; do
        # shellcheck disable=SC2184
        [[ ${auxArr[i]} == "$fieldVal" ]] && unset auxArr[i]
    done
    auxArr=("$fieldVal" "${auxArr[@]}")
    printf -v "$varName" '%s' "${auxArr[*]}"
}
# FIXME: replace with a C version

# see http://stackoverflow.com/questions/24515385/is-there-a-general-way-to-add-prepend-remove-paths-from-general-environment-vari
field_append() {
    local varName=$1 fieldVal=$2 IFS=${3:-':'} auxArr
    read -ra auxArr <<< "${!varName}"
    for i in "${!auxArr[@]}"; do
        # shellcheck disable=SC2184
        [[ ${auxArr[i]} == "$fieldVal" ]] && unset auxArr[i]
    done
    auxArr+=("$fieldVal")
    printf -v "$varName" '%s' "${auxArr[*]}"
}
# FIXME: replace with a C version

# see http://stackoverflow.com/questions/24515385/is-there-a-general-way-to-add-prepend-remove-paths-from-general-environment-vari
field_remove() {
    local varName=$1 fieldVal=$2 IFS=${3:-':'} auxArr
    read -ra auxArr <<< "${!varName}"
    for i in "${!auxArr[@]}"; do
        # shellcheck disable=SC2184
        [[ ${auxArr[i]} == "$fieldVal" ]] && unset auxArr[i]
    done
    printf -v "$varName" '%s' "${auxArr[*]}"
}
# FIXME: replace with a C version

field_remove_with_wildcards() {
    local varName=$1 fieldVal=$2 IFS=${3:-':'} auxArr
    read -ra auxArr <<< "${!varName}"
    for i in "${!auxArr[@]}"; do
        # shellcheck disable=SC2184,SC2053
        [[ ${auxArr[i]} == $fieldVal ]] && unset auxArr[i]
    done
    printf -v "$varName" '%s' "${auxArr[*]}"
}
# FIXME: replace with a C version

exit_if_root() {
    if test "$(id -u)" -eq 0; then
        echo "can't run this program as root"
        exit 1
    fi
}

function cleanup_directories()
{
    if test "${MODULE_RUNTIME_HOME}" != ""; then
        for REP in tmp var log; do
        if test -d "${MODULE_RUNTIME_HOME}/${REP}"; then
            echo -n "- Cleaning ${MODULE_RUNTIME_HOME}/${REP}..."
            cd "${MODULE_RUNTIME_HOME}/${REP}" && rm -Rf ./* >/dev/null 2>&1
            echo_ok
        fi
        done
    fi
}
# FIXME: inline this function

function cleanup_pyc()
{
    if test "${MODULE_RUNTIME_HOME}" != ""; then
        find "${MODULE_RUNTIME_HOME}" -name "*.pyc" -delete
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
    NEWERS="/etc/hosts /etc/resolv.conf /etc/nsswitch.conf /etc/metwork.config ${MFCOM_HOME}/config/config.ini ${MODULE_HOME}/config/config.ini ${MODULE_RUNTIME_HOME}/config/config.ini"
    if test -f "/etc/metwork.config.d/${MODULE_LOWERCASE}/config.ini"; then
        NEWERS="${NEWERS} /etc/metwork.config.d/${MODULE_LOWERCASE}/config.ini"
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
    eval "$("${MFEXT_HOME}/bin/layer_unload_bash_cmds" "--debug" "$@" 2>"${LAYER_UNLOAD_TMP}")"
    cat "${LAYER_UNLOAD_TMP}"
    rm -f "${LAYER_UNLOAD_TMP}"
}

function layer_load()
{
    local LAYER_LOAD_TMP
    LAYER_LOAD_TMP=$(mktemp)
    eval "$("${MFEXT_HOME}/bin/layer_load_bash_cmds" "--debug" "$@" 2>"${LAYER_LOAD_TMP}")"
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
