{% extends "layer.md" %}

{% block overview %}

The `layer1_python2_misc` layer includes Python2 misc packages and utilities.

{% endblock %}

{% block utilities %}

{{ utility("layer_wrapper --layers=python2_misc@mfext -- get_ip_for_hostname", displayed_name="get_ip_for_hostname") }}
{{ utility("layer_wrapper --layers=python2_misc@mfext -- get_simple_hostname", displayed_name="get_simple_hostname") }}
{{ utility("layer_wrapper --layers=python2_misc@mfext -- get_full_hostname", displayed_name="get_full_hostname") }}
{{ utility("layer_wrapper --layers=python2_misc@mfext -- get_real_ip", displayed_name="get_real_ip") }}
{{ utility("layer_wrapper --layers=python2_misc@mfext -- ping_tcp_port", displayed_name="ping_tcp_port") }}
{{ utility("layer_wrapper --layers=python2_misc@mfext -- recursive_kill.py", displayed_name="recursive_kill.py") }}

{% endblock %}
