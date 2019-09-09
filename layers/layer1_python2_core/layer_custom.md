{% extends "layer.md" %}

{% block overview %}

The `python2_core` layer includes a minimal [(C) Python2](http://python.org) distribution.

Some additional packages are installed to be able to use `pip` and `virtualenv` commands.

Other packages are put in the (main) `python2` layer.

This layer is not loaded by default and conflicts with `python3_core` layer.
So you have to use `layer_wrapper` or bash `layer_load` before using
included packages.

.. note::
    There is also a `python3` wrapper (see utilities) available in this layer which is the way to go if you want to execute a python3 script from a python2 environment (for example with this layer loaded).

{% endblock %}

{% block utilities %}

{{ utility("layer_wrapper --layers=python2@mfext -- python3", displayed_name="python3") }}

{% endblock %}
