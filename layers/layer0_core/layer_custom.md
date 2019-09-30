{% extends "layer.md" %}

{% block overview %}

The `core` layer includes core packages which are always available. The `core`
layer is loaded by default (as the :ref:`root layer <layer_root>`). It can therefore be seen as an
extension of the :ref:`root layer <layer_root>`.

The distinction between the two is solely due to technical constraints.

{% endblock %}

{% block utilities %}

#### layerapi2 utilities

See also [layerapi2 README for details](https://github.com/metwork-framework/layerapi2/blob/master/README.md).

{{ utility("layers", level="#####") }}
{{ utility("is_layer_installed", level="#####") }}
{{ utility("is_layer_loaded", level="#####") }}
{{ utility("layer_wrapper", level="#####") }}

##### misc utilities

{{ utility("echo_ok", level="#####") }}
{{ utility("echo_bold", level="#####") }}
{{ utility("echo_nok", level="#####") }}
{{ utility("echo_warning", level="#####") }}
{{ utility("echo_running", level="#####") }}
{{ utility("get_unique_hexa_identifier", level="#####") }}

{% endblock %}
