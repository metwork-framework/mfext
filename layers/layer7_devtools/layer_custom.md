{% extends "layer.md" %}

{% block overview %}

The `devtools` layer is a set of CLI developer tools.

{% endblock %}

{% block utility %}

{{ utility("shellchecks") }}
{{ utility("test_globals_in_lua.sh") }}

{% endblock %}
