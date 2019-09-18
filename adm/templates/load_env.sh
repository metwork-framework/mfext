if test "${MFMODULE}" = "{{MFMODULE}}"; then
    echo "WARNING: environnement already set"
    return
fi
if test "${MFMODULE}" != ""; then
    echo "ERROR: environnement already set for another metwork module"
    return
fi

if ! test "`whoami`" = "{{MFMODULE_LOWERCASE}}"; then
    if test "${MFMODULE_RUNTIME_SUFFIX}" = ""; then
        export MFMODULE_RUNTIME_SUFFIX=metwork/{{MFMODULE_LOWERCASE}}
    fi
fi

. {{MFMODULE_HOME}}/share/interactive_profile

if test $? -ne 0; then
    echo "ERROR: can't load {{MFMODULE_HOME}}/share/interactive_profile"
    return
fi
if test "${PROFILE_ERROR}" = "1"; then
    echo "ERROR: ERRORS FOUND DURING PROFILE LOADING"
    return
fi

{% if ROOT_DIR == "RUNTIME" %}
    cd ${MFMODULE_RUNTIME_HOME} || exit 1
{% else %}
    cd {{ROOT_DIR}} || exit 1
{% endif %}

function custom_cd() {
    if test "$1" = ""; then
        {% if ROOT_DIR == "RUNTIME" %}
            "cd" ${MFMODULE_RUNTIME_HOME}
        {% else %}
            "cd" {{ROOT_DIR}}
        {% endif %}
    else
        "cd" "$@"
    fi
}
alias cd=custom_cd
