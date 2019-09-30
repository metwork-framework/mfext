## What is MFEXT ?

This is the **M**etwork **F**ramework "**EXT**ernal dependencies" **module**. This module is a "dependencies package" ridiculously easy to install which add to a Linux distribution plenty of recent softwares, especially for scientific and meteorology domain. 

This module does not contain any services, it is just a bunch of files and directories installed in `/opt` directory
(so installing **MFEXT** module can't break anything on your system).

Usually **MFEXT** is just a dependency of other MetWork Framework **modules** (like [mfserv](https://github.com/metwork-framework/mfserv) or [mfdata](https://github.com/metwork-framework.org/mfdata)) but it can also be used alone like you can see on the short (< 30s) following screencast:

[![asciicast](https://asciinema.org/a/uNsG6AaPkMeZ3Lb8NsW4vMkYa.png)](https://asciinema.org/a/uNsG6AaPkMeZ3Lb8NsW4vMkYa)

### Concepts

#### Layers

**MFEXT** is staged in logical and/or technical **layers**. Some of them are optional,
you can choose not to install them (for example, layers about Python2). Each layer contains
one or several **components**.

For example, here are some **layers** hosted on this repository:

- `python3_core` which contains several core **components** for Python3: `python3`, `pip`, `virtualenv`...
- `python3` which contains several additional **components** for Python3: `requests`, `psutil`, `filelock`...
- `openresty` which contains: `openresty`, `lua_restry_http`, `lua_resty_cookie`... **components**
- `nodejs` which contains only one package: `nodejs`
- [...]

You can inspect installed layers with the `layers` utility.

#### Components

Most of theses **components** are not
maintained by the MetWork Framework team. For example, you will find inside a recent [Python](http://www.python.org) interpreter or some well known libraries like [CURL](https://curl.haxx.se/) or [GLIB2](https://developer.gnome.org/glib/).

You can inspect installed components with the `components` utility.

#### Add-ons

This repository holds a lot of **layers** but you will also find extra **layers** in **MFEXT addons**
repositories. Let's mention in particular [mfextaddon_scientific](https://github.com/metwork-framework/mfextaddon_scientific) which provides some **layers** with a lot of geospatial and
scientific tools.

An add-on to **MFEXT** can be maintained by anyone and can be hosted anywhere. But below, you
will find officially maintained **MFEXT addons**:

| Addon | Description |
| --- | --- |
| [mfextaddon_scientific](https://github.com/metwork-framework/mfextaddon_scientific) | mfext Add-on for scientific libraries and tools |
| [mfextaddon_python3_ia](https://github.com/metwork-framework/mfextaddon_python3_ia) | mfext Add-on for deep learning/IA libraries and tools for Python3 |
| [mfextaddon_mapserver](https://github.com/metwork-framework/mfextaddon_mapserver) | mfext Add-on which provides [Mapserver software](https://mapserver.org) and libraries around ([mapserverapi](https://github.com/metwork-framework/mapserverapi)) and [mapserverapi_python](https://github.com/metwork-framework/mapserverapi_python)) |
| [mfextaddon_vim](https://github.com/metwork-framework/mfextaddon_vim) | mfext Add-on which provides an opinionated vim editor (including configuration) for use in MetWork Framework env |

An add-on can contain one or several extra **layers**.

## Quickstart

### Installation

**On a Linux CentOS 7 box**

```bash

# AS ROOT USER

# First, we configure the Metwork Framework repository for stable release on CentOS 7
cat >/etc/yum.repos.d/metwork.repo <<EOF
[metwork_stable]
name=MetWork Stable
baseurl=http://metwork-framework.org/pub/metwork/releases/rpms/stable/centos7/
gpgcheck=0
enabled=1
metadata_expire=0
EOF

# Then we install a minimal version of mfext module
yum -y install metwork-mfext-minimal

# Done :-)

# Then let's install (for the example only) an extra layer
# (to add Python2 support)
yum -y install metwork-mfext-layer-python2
```

### Usage

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

$ # Test your python version (recent Python3 version)
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

$ # Note: you have two components because you have one in python2_core layer
$ #       (currently loaded because you have the (*) sign before) and one
$ #       in (not loaded) python3_core layer.

```

## More details

After installation, there is no service to initialize or to start.

All the files are located in `/opt/metwork-mfext-{BRANCH}` directory with probably
a `/opt/metwork-mfext => /opt/metwork-mfext-{BRANCH}` symbolic link (in very particular
and advanced use cases, you can choose not to install the symbolic link).

Because `/opt` is not used by default on [standard Linux](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard), **the installation shouldn't break anything.**

Therefore, if you do nothing specific after the installation, you won't benefit
from any included software components!

So, to use this module, you have to load a kind of "mfext environment". There are several ways to do that.

In the following, we use `{MFEXT_HOME}` as the installation directory of the `mfext` module. It's probably something like `/opt/metwork-mfext-{BRANCH}` or `/opt/metwork-mfext`. Have a look in `/opt` directory.

### Load the mfext environment (for one command only)

If you want to load the "mfext environment" for one command only and return back to a standard running environment after that, you can use the specific wrapper:

```console
$ # what is the version of the python command ?
$ python --version
Python 2.6.6
$ # => this is a very old python version

$ # what is the version of the python command (with mfext environment loaded) ?
$ {MFEXT_HOME}/bin/mfext_wrapper python --version
Python 3.7.3
$ # => this is a recent python version

$ # what is the version of the python command ?
$ python --version
Python 2.6.6
$ # => We are back to our original system python command
```

### Load the mfext environment (for the whole shell session)

If you are tired to use `mfext_wrapper` repeatedly, you can load the "mfext environment"
for the whole shell session with:

- `. {MFEXT_HOME}/share/interative_profile`
- (or) `. {MFEXT_HOME}/share/profile` (for non interactive stuff)

See "Quickstart" section below for a complete example.

### Load the mfext environment (automatically for one user)

If you want to have a unix user with "always loaded" metwork environment, you can add:

```
source {MFEXT_HOME}/share/interactive_profile
```

in (for example) in the user `.bash_profile` file.

**Note: we do not recommend to use this for a user with a full graphical interface because of possible side effects with desktop environment.**

An alternative way is to add

```
alias mfext="source {MFEXT_HOME}/share/interactive_profile"
```

in `.bash_profile` file and use this `mfext` alias when you want to quickly load the "mfext environment".

### Unloading the mfext environment

If you want to "unload" the "mfext environment" to launch an external command which doesn't play well with metwork libraries
or tools (because of version conflicts for example), you can use the `outside` command wrapper.

```console

$ # . {MFEXT_HOME}/share/interactive_profile
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
