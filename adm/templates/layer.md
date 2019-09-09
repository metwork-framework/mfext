.. _layer_{{LAYER_NAME}}:

{% macro utility(name, displayed_name="", level="####") %}
{% if displayed_name != "" %}
.. index:: {{displayed_name}} utility
{{level}} {{displayed_name}}
{% else %}
.. index:: {{name}} utility
{{level}} {{name}}
{% endif %}

{% if called is defined %}
{{caller}}
{% endif %}

```console
{{ (name + " --help")|shell }}
```
{% endmacro %}

## Layer {{LAYER_NAME}}

### Overview

{% block overview %}
{% endblock %}

{% block metadata %}
### Metadata

#### Layer Home

{% if LAYER_NAME == "root" %}
`{{MODULE_HOME}}`
{% else %}
`{{MODULE_HOME}}/opt/{{LAYER_NAME}}`
{% endif %}

#### Label

`{{LABEL}}`

#### Package

`{{PACKAGE}}`

{% if DEPENDENCIES %}

#### Dependencies

{% set deps = DEPENDENCIES.split(',') %}
{% for dep in deps %}
{% if dep.startswith('-') %}- `{{ dep[1:] }}` (optional){% else %}- `{{dep}}`{% endif %}
{% endfor %}

{% endif %}

{% if SYSTEM_DEPENDENCIES %}
#### System dependencies (for "generic build")

{% set deps = SYSTEM_DEPENDENCIES.split('~') %}
{% for dep in deps %}
- `{{dep}}`
{% endfor %}

{% endif %}

{% if CONFLICTS %}

#### Conflicts

{% set cfs = CONFLICTS.split(',') %}
{% for cf in cfs %}
- `{{cf}}`
{% endfor %}

{% endif %}

{% if EXTRA_ENV %}

#### Extra-environment (loaded after layer load)

```
{{EXTRA_ENV}}
```

{% endif %}

{% if EXTRA_PROFILE %}

#### Extra interactive profile (loaded after layer load in interactive mode only)

```
{{EXTRA_PROFILE}}
```

{% endif %}

{% if EXTRA_UNPROFILE %}

#### Extra interactive (un)profile (loaded after layer unload in interactive mode only)

```
{{EXTRA_UNPROFILE}}
```

{% endif %}

{% endblock %}

{% if self.utilities() or MODULE not in ['MFEXT', 'MFCOM'] %}
### Utilities
{% endif %}

{% if MODULE not in ['MFEXT', 'MFCOM'] and LAYER_NAME == "root" %}

#### {{MODULE_LOWERCASE}}.stop

Stop the `{{MODULE_LOWERCASE}}` module. This is nearly
the same thing than `service metwork stop {{MODULE_LOWERCASE}}` (as `root` user).

#### {{MODULE_LOWERCASE}}.status

Get the status of the `{{MODULE_LOWERCASE}}` module. This is nearly
the same thing than `service metwork status {{MODULE_LOWERCASE}}` (as `root` user).

The (unix) return code will be `0` if the module is ok.

{{ utility(MODULE_LOWERCASE + "_wrapper") }}

{% endif %}

{% block utilities %}
{% endblock %}

{% if PACKAGES %}

### Packages

{% include 'packages.md' %}

{% endif %}
