{% extends "layer.md" %}

{% block overview %}

The `python3_circus` layer includes the [circus](https://circus.readthedocs.org/) software
used in all metwork modules (except mfext/mfcom).

This layer is not loaded by default. But, of course, circus processes are launched with
this layer loaded.

{% endblock %}
