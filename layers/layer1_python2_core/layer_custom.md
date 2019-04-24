{% extends "layer.md" %}

{% block overview %}

The `python2_core` layer includes a minimal [(C) Python2](http://python.org) distribution.

Some additional packages are installed to be able to use `pip` and `virtualenv` commands.

Other packages are put in the (main) `python2` layer.

This layer is not loaded by default and conflicts with `python3_core` layer.
So you have to use `layer_wrapper` or bash `layer_load` before using
included packages.

.. note::
    There is also a :ref:`python2 wrapper<layer_root_python2_wrapper>` available in the :ref:`root layer<layer_root>` which is the way to go if you want to execute a python2 script without any question about currently loaded layers.

{% endblock %}
