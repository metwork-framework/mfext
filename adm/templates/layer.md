.. _layer_{{LAYER_NAME}}:

# Layer {{LAYER_NAME}}

## Overview

{% block overview %}
{% endblock %}

{% block metadata %}
## Metadata

### Layer Home

{% if LAYER_NAME == "root" %}
{{MODULE_HOME}}
{% else %}
{{MODULE_HOME}}/opt/{{LAYER_NAME}}
{% endif %}

### Label

{{LABEL}}

{% if DEPENDENCIES %}

### Dependencies

{% set deps = DEPENDENCIES.split(',') %}
{% for dep in deps %}
- {{dep}}
{% endfor %}

{% endif %}

{% if CONFLICTS %}

### Conflicts

{% set cfs = CONFLICTS.split(',') %}
{% for cf in cfs %}
- {{cf}}
{% endfor %}

{% endif %}

{% if EXTRA_ENV %}

### Extra-environment (loaded after layer load)

```none
{{EXTRA_ENV}}
```

{% endif %}

{% if EXTRA_PROFILE %}

### Extra interactive profile (loaded after layer load in interactive mode only)

```none
{{EXTRA_PROFILE}}
```

{% endif %}

{% if EXTRA_UNPROFILE %}

### Extra interactive (un)profile (loaded after layer unload in interactive mode only)

```none
{{EXTRA_UNPROFILE}}
```

{% endif %}

{% endblock %}

{% if UTILITIES %}
## Utilities

{% set utils = UTILITIES.split(',') %}
{% for util in utils %}

.. index:: {{util}}
### {{util}}

{% if LAYER_NAME == "root" %}
{% set CMD = "layer_wrapper --layers=" + LABEL + " -- " + MODULE_HOME + "/bin/" + util + " --help" %}
{% else %}
{% set CMD = "layer_wrapper --layers=" + LABEL + " -- " + MODULE_HOME + "/opt/" + LAYER_NAME + "/bin/" + util + " --help" %}
{% endif %}
```none
{{CMD|shell}}
```

{% endfor %}
{% endif %}

{% if PACKAGES %}

## Packages

{% include 'packages.md' %}

{% endif %}
