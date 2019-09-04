[![logo](https://raw.githubusercontent.com/metwork-framework/resources/master/logos/metwork-white-logo-small.png)](http://www.metwork-framework.org)
#  mfext

[//]: # (automatically generated from https://github.com/metwork-framework/resources/blob/master/cookiecutter/_%7B%7Bcookiecutter.repo%7D%7D/README.md)

**Status (master branch)**



[![Drone CI](http://metwork-framework.org:8000/api/badges/metwork-framework/mfext/status.svg)](http://metwork-framework.org:8000/metwork-framework/mfext)
[![Maintenance](https://github.com/metwork-framework/resources/blob/master/badges/maintained.svg)]()
[![License](https://github.com/metwork-framework/resources/blob/master/badges/bsd.svg)]()
[![Gitter](https://github.com/metwork-framework/resources/blob/master/badges/community-en.svg)](https://gitter.im/metwork-framework/community-en?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
[![Gitter](https://github.com/metwork-framework/resources/blob/master/badges/community-fr.svg)](https://gitter.im/metwork-framework/community-fr?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)


**Table of contents**

* [1\. What is MFEXT ?](#1-what-is-mfext-)
* [2\. Quickstart](#2-quickstart)
* [3\. More details](#3-more-details)
* [4\. Reference documentation](#4-reference-documentation)
* [5\. Installation guide](#5-installation-guide)
* [6\. Contributing guide](#6-contributing-guide)
* [7\. Code of Conduct](#7-code-of-conduct)
* [8\. Sponsors](#8-sponsors)



## 1. What is MFEXT ?

This is the **M**etwork **F**ramework "**EXT**ernal dependencies" **module**. This module does not contain any services, it is just a bunch of files and directories.

Usually **MFEXT** is just a dependency of other MetWork Framework **modules** (like [mfserv](https://github.com/metwork-framework/mfserv) or [mfdata](https://github.com/metwork-framework.org/mfdata)) but it can also be used alone like you can see on the short (< 30s) following screencast:

[![asciicast](https://asciinema.org/a/uNsG6AaPkMeZ3Lb8NsW4vMkYa.png)](https://asciinema.org/a/uNsG6AaPkMeZ3Lb8NsW4vMkYa)

### 1.1 Concepts

#### 1.1.1 Layers

**MFEXT** is staged in logical and/or technical **layers**. Some of them are optional,
you can choose not to install them (for example, layers about Python2). Each layer contains
one or several **components**.

For example, here are some **layers** hosted on this repository:

- `python3_core` which contains several core **components** for Python3: `python3`, `pip`, `virtualenv`...
- `python3` which contains several additional **components** for Python3: `requests`, `psutil`, `filelock`...
- `openresty` which contains: `openresty`, `lua_restry_http`, `lua_resty_cookie`... **components**
- `nodejs` which contains only one package: `nodejs`
- [...]

#### 1.1.2 Components

Most of theses **components** are not
maintained by the MetWork Framework team. For example, you will find inside a recent [Python](http://www.python.org) interpreter or some well known libraries like [CURL](https://curl.haxx.se/) or [GLIB2](https://developer.gnome.org/glib/).

#### 1.1.3 Add-ons

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

## 2. Quickstart

### 2.1 Installation

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

### 2.2 Usage

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
```

## 3. More details

After installation, there is no service to initialize or to start.

All the files are located in `/opt/metwork-mfext-{BRANCH}` directory with probably
a `/opt/metwork-mfext => /opt/metwork-mfext-{BRANCH}` symbolic link (in very particular
and advanced use cases, you can choose not to install the symbolic link).

Because `/opt` is not used by default on [standard Linux](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard), **the installation shouldn't break anything.**

Therefore, if you do nothing specific after the installation, you won't benefit
from any included software components!

So, to use this module, you have to load a kind of "mfext environment". There are several ways to do that.

In the following, we use `{MFEXT_HOME}` as the installation directory of the `mfext` module. It's probably something like `/opt/metwork-mfext-{BRANCH}` or `/opt/metwork-mfext`. Have a look in `/opt` directory.

### 3.1 Load the mfext environment (for one command only)

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

### 3.2 Load the mfext environment (for the whole shell session)

If you are tired to use `mfext_wrapper` repeatedly, you can load the "mfext environment"
for the whole shell session with:

- `. {MFEXT_HOME}/share/interative_profile`
- (or) `. {MFEXT_HOME}/share/profile` (for non interactive stuff)

See "Quickstart" section below for a complete example.

### 3.3 Load the mfext environment (automatically for one user)

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

### 3.4 Unloading the mfext environment

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




## 4. Reference documentation

- (for **master (development)** version), see [this dedicated site](http://metwork-framework.org/pub/metwork/continuous_integration/docs/master/mfext/) for reference documentation.
- (for **latest released stable** version), see [this dedicated site](http://metwork-framework.org/pub/metwork/releases/docs/stable/mfext/) for reference documentation.

For very specific use cases, you might be interested in
[reference documentation for integration branch](http://metwork-framework.org/pub/metwork/continuous_integration/docs/integration/mfext/).

And if you are looking for an old released version, you can search [here](http://metwork-framework.org/pub/metwork/releases/docs/).

## 5. Installation guide

See [this document](.metwork-framework/install_a_metwork_package.md).




## 6. Contributing guide

See [CONTRIBUTING.md](CONTRIBUTING.md) file.



## 7. Code of Conduct

See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) file.



## 8. Sponsors

*(If you are officially paid to work on MetWork Framework, please contact us to add your company logo here!)*

[![logo](https://raw.githubusercontent.com/metwork-framework/resources/master/sponsors/meteofrance-small.jpeg)](http://www.meteofrance.com)
