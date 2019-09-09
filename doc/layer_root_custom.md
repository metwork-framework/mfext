{% extends "layer.md" %}

{% block overview %}
This is the `root` layer of the MFEXT module.

This layer mainly includes some utilities (mainly internal).

{% endblock %}

{% block utilities %}

{{ utility("clear.sh") }}
{{ utility("metwork_debug") }}
{{ utility("outside") }}

{% endblock %}
