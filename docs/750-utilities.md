# Utilities

!!! note
    **These utilities are only those maintained by the MetWork project.**

    You can find many others provided by other [components]({{components}}).

## Core layers

!!! note
    These utilities are located in core/minimal layers. So they are nearly
    always available.

{{ declare_utility("outside", level=3) }}
{{ declare_utility("components") }}
{{ declare_utility("layers") }}
{{ declare_utility("plugin_wrapper") }}
{{ declare_utility("mfext_wrapper") }}
{{ declare_utility("metwork_debug") }}
{{ declare_utility("log") }}
{{ declare_utility("echo_ok") }}
{{ declare_utility("echo_bold") }}
{{ declare_utility("echo_clean") }}
{{ declare_utility("echo_nok") }}
{{ declare_utility("echo_warning") }}
{{ declare_utility("echo_running") }}
{{ declare_utility("is_interactive") }}
{{ declare_utility("is_layer_installed") }}
{{ declare_utility("is_layer_loaded") }}
{{ declare_utility("layer_wrapper") }}
{{ declare_utility("log_proxy") }}
{{ declare_utility("log_proxy_wrapper") }}
{{ declare_utility("unsafe_pip") }}
{{ declare_utility("get_unique_hexa_identifier") }}
{{ declare_utility("get_layer_home") }}
{{ declare_utility("get_simple_hostname") }}
{{ declare_utility("get_full_hostname") }}
{{ declare_utility("get_domainname") }}
{{ declare_utility("get_real_ip") }}
{{ declare_utility("get_ip_for_hostname") }}


## Python3 layers

!!! note
    These utilities are only available when "python3" layers are loaded.

### python3_wrapper
```console
$ python3_wrapper --help
usage: python3_wrapper [PYTHON_ARGS]
  => launch a python3 command inside a python3 env
```

## Dev layers

!!! note
    These utilities are only available when the "devtools" layers is loaded.

### flake8.sh
{{ declare_utility("flake8.sh") }}

### pylint.sh
{{ declare_utility("pylint.sh") }}

### nosetests.sh
{{ declare_utility("nosetests.sh") }}

{{ declare_utility("shellchecks") }}
{{ declare_utility("test_globals_in_lua.sh") }}
{{ declare_utility("noutf8.sh") }}
