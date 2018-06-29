{% extends "layer.md" %}

{% block overview %}

The `openresty` layer includes an [openresty](http://openresty.org) distribution.

Of course, this distribution includes the main `openresty` package (as you
can download on the previous website) and included components.

But some other "non official" components are also included.

This layer is not loaded by default. So you have to use `layer_wrapper` or bash
`layer_load` before using included packages.

{% endblock %}
