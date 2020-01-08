# Quickstart

{% macro opt_mfext_not_found() -%}
??? failure "`/opt/metwork-mfext` does not exist on your system?"
    In some particular and advanced use cases (custom build, several mfext versions
    installed in parallel...) the symbolic link `/opt/metwork-mfext` can be missing.

    Please replace `/opt/metwork-mfext` in this document by your custom `MFEXT_HOME` (probably
    something like `/opt/metwork-mfext-X.Y`).

    If you don't know, have a look in your `/opt` directory.
{%- endmacro %}

## Installation

**On a Linux CentOS 6, 7 or 8 box**

??? question "What about other Linux distributions?"
    This quickstart is easily adaptable to other Linux distributions. To install
    on your favorite one, have a look at the [complete installation guide]({{installation_guide}}).

```bash

# AS ROOT USER

# First, we configure the Metwork Framework repository for stable releases
cat >/etc/yum.repos.d/metwork.repo <<EOF
[metwork_stable]
name=MetWork Stable
baseurl=http://metwork-framework.org/pub/metwork/releases/rpms/stable/portable/
gpgcheck=0
enabled=1
metadata_expire=0
EOF

# Then we install a minimal version of mfext module
yum -y install metwork-mfext

# Done :-)

# Then let's install (for the example only) an extra layer
# (to add Python2 support)
yum -y install metwork-mfext-layer-python2
```

## Usage

```console

$ # AS ANY USER (can be root or a non priviligied one)

$ # Test your python version (old system one)
$ python --version
Python 2.7.5

$ # We load the mfext (interactive) profile for the current session
$ # (note: there is also a regular profile (without banner and custom bash prompt)
$ # for non-interactive stuff)
$ . /opt/metwork-mfext/share/interactive_profile
           __  __      ___          __        _
          |  \/  |    | \ \        / /       | |
          | \  / | ___| |\ \  /\  / /__  _ __| | __
          | |\/| |/ _ \ __\ \/  \/ / _ \| '__| |/ /
          | |  | |  __/ |_ \  /\  / (_) | |  |   <
          |_|  |_|\___|\__| \/  \/ \___/|_|  |_|\_\

 11:24:50 up 61 days, 57 min,  1 user,  load average: 1.26, 1.77, 2.13

$ # Test your new python version (recent Python3 version)
$ python --version
Python 3.7.3

$ # See installed layers (currently loaded layers are prefixed by (*))
$ layers
- (*) python3@mfext [/opt/metwork-mfext-0.8/opt/python3]
- (*) python3_core@mfext [/opt/metwork-mfext-0.8/opt/python3_core]
- (*) default@mfext [/opt/metwork-mfext-0.8/opt/default]
- (*) core@mfext [/opt/metwork-mfext-0.8/opt/core]
- python2_core@mfext [/opt/metwork-mfext-0.8/opt/python2_core]
- python2@mfext [/opt/metwork-mfext-0.8/opt/python2]
- (*) root@mfext [/opt/metwork-mfext-0.8]

$ # Let's load the python2 extra layer
$ layer_load python2@mfext

$ layers # note: currently loaded layers are prefixed by (*)
- python3@mfext [/opt/metwork-mfext-0.8/opt/python3]
- python3_core@mfext [/opt/metwork-mfext-0.8/opt/python3_core]
- default@mfext [/opt/metwork-mfext-0.8/opt/default]
- (*) core@mfext [/opt/metwork-mfext-0.8/opt/core]
- (*) python2_core@mfext [/opt/metwork-mfext-0.8/opt/python2_core]
- (*) python2@mfext [/opt/metwork-mfext-0.8/opt/python2]
- (*) root@mfext [/opt/metwork-mfext-0.8]

$ python --version (latest Python 2.7 version, this is not the system version)
Python 2.7.15

$ # See available components for the current env
$ components --loaded-filter=yes
- (*) libressl-2.9.2 (module: mfext, layer: core@mfext)
- (*) mfutil_c-0.0.4 (module: mfext, layer: core@mfext)
- (*) glib-2.56.4 (module: mfext, layer: core@mfext)
- (*) yajl-2.1.0 (module: mfext, layer: core@mfext)
- (*) libxml2-2.9.7 (module: mfext, layer: core@mfext)
- (*) pcre-8.36 (module: mfext, layer: core@mfext)
[...]

$ # See full details about a given component
$ components --name=virtualenv --full
- virtualenv-16.6.0 (module: mfext, layer: python3_core@mfext)
    => website: https://virtualenv.pypa.io/
    => description: Virtual Python Environment builder
    => license: MIT
- (*) virtualenv-16.6.0 (module: mfext, layer: python2_core@mfext)
    => website: https://virtualenv.pypa.io/
    => description: Virtual Python Environment builder
    => license: MIT

$ # Note: you have two virtualenv components because you have one in
$ #       python2_core layer (currently loaded because you have
$ #       the (*) sign before) and one in (not loaded) python3_core layer.

```

## More details

After installation, there is no service to initialize or to start.

All the files are located in `/opt/metwork-mfext-{X.Y}` directory with probably
a `/opt/metwork-mfext => /opt/metwork-mfext-{X.Y}` symbolic link (in very particular
and advanced use cases, you can choose not to install the symbolic link).

Because `/opt` is not used by default on [standard Linux](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard), **the installation shouldn't break anything.**

Therefore, if you do nothing specific after the installation, you won't benefit
from any included software components!

So, to use this module, you have to load a kind of "mfext environment". There are several ways to do that.

!!! info "MFEXT_HOME"
    In the following, we use `/opt/metwork-mfext` as the installation directory of the `mfext` module (this is the case in 99% of installations). But in some very particular use cases, it
    can be something slightly different.

## Load the mfext environment

### For one command only

If you want to load the "mfext environment" for one command only and return back to a standard running environment after that, you can use the specific wrapper:

```console
$ # what is the version of the python command ?
$ python --version
Python 2.6.6
$ # => this is a very old python version

$ # what is the version of the python command (with mfext environment loaded) ?
$ /opt/metwork-mfext/bin/mfext_wrapper python --version
Python 3.7.3
$ # => this is a recent python version

$ # what is the version of the python command ?
$ python --version
Python 2.6.6
$ # => We are back to our original system python command
```

{{ opt_mfext_not_found() }}

### For the whole shell session

If you are tired to use `mfext_wrapper` repeatedly, you can load the "mfext environment"
for the whole shell session with:

- `. /opt/metwork-mfext/share/interative_profile`
- (or) `. /opt/metwork-mfext/share/profile` (for non interactive stuff)

See "Quickstart" section below for a complete example.

{{ opt_mfext_not_found() }}

### Automatically for one user

If you want to have a unix user with "always loaded" metwork environment, you can add:

```
source /opt/metwork-mfext/share/interactive_profile
```

{{ opt_mfext_not_found() }}

(for example) in the user `.bash_profile` file.

!!! warning
    We **do not recommend** to use this for a user with a full graphical interface because of possible side effects with desktop environment.

An alternative way is to add

```
alias mfext="source /opt/metwork-mfext/share/interactive_profile"
```

in `.bash_profile` file and use this `mfext` alias when you want to quickly load the "mfext environment".

## Unloading the mfext environment

If you want to "unload" the "mfext environment" to launch an external command which doesn't play well with metwork libraries
or tools (because of version conflicts for example), you can use the `outside` command wrapper.

```console

$ # . /opt/metwork-mfext/share/interactive_profile
[...]

$ python --version
Python 3.7.3
$ # => the mfext environment is loaded

$ outside python --version
Python 2.7.5
$ # => we lauched the python command outside the mfext environment
$ #    (so we got the system version)

$ python --version
Python 3.7.3
$ # => the mfext environment is still loaded
```
