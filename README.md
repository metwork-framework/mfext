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
* [4\. Full list of components](#4-full-list-of-components)
* [5\. Reference documentation](#5-reference-documentation)
* [6\. Installation guide](#6-installation-guide)
* [7\. Contributing guide](#7-contributing-guide)
* [8\. Code of Conduct](#8-code-of-conduct)
* [9\. Sponsors](#9-sponsors)



## 1. What is MFEXT ?

This is the **M**etwork **F**ramework "**EXT**ernal dependencies" **module**. This module is a "dependencies package" ridiculously easy to install which add to a Linux distribution plenty of recent softwares, especially for scientific and meteorology domain. 

This module does not contain any services, it is just a bunch of files and directories installed in `/opt` directory
(so installing **MFEXT** module can't break anything on your system).

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

You can inspect installed layers with the `layers` utility.

#### 1.1.2 Components

Most of theses **components** are not
maintained by the MetWork Framework team. For example, you will find inside a recent [Python](http://www.python.org) interpreter or some well known libraries like [CURL](https://curl.haxx.se/) or [GLIB2](https://developer.gnome.org/glib/).

You can inspect installed components with the `components` utility.

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







## 4. Full list of components

| Name | Version | Layer |
| --- | --- | --- |
| [Babel](http://babel.pocoo.org/) | 2.7.0 | python3_devtools |
| [Click](https://palletsprojects.com/p/click/) | 7.0 | python3 |
| [ConfigArgParse](https://github.com/bw2/ConfigArgParse) | 0.14.0 | python2 |
| [ConfigArgParse](https://github.com/bw2/ConfigArgParse) | 0.14.0 | python3 |
| [Jinja2](http://jinja.pocoo.org/) | 2.10.1 | python2 |
| [Jinja2](http://jinja.pocoo.org/) | 2.10.1 | python3 |
| [MarkupSafe](https://palletsprojects.com/p/markupsafe/) | 1.1.1 | python2 |
| [MarkupSafe](https://palletsprojects.com/p/markupsafe/) | 1.1.1 | python3 |
| [PyYAML](https://github.com/yaml/pyyaml) | 5.1.2 | python2 |
| [PyYAML](https://github.com/yaml/pyyaml) | 5.1.1 | python3 |
| [Pygments](http://pygments.org/) | 2.4.2 | python3_devtools |
| [Python](http://python.org/) | 2.7.16 | python2_core |
| [Python](http://python.org/) | 3.7.3 | python3_core |
| [Sphinx](http://sphinx-doc.org/) | 2.2.0 | python3_devtools |
| [Unidecode](https://pypi.org/project/Unidecode) | 1.1.1 | python2 |
| [Unidecode](https://pypi.org/project/Unidecode) | 1.1.1 | python3 |
| [Werkzeug](https://palletsprojects.com/p/werkzeug/) | 0.15.5 | python2_devtools |
| [Werkzeug](https://palletsprojects.com/p/werkzeug/) | 0.15.5 | python3_devtools |
| [ack](https://beyondgrep.com/) | 2.16-single-file | devtools |
| [alabaster](https://alabaster.readthedocs.io) | 0.7.12 | python3_devtools |
| [appdirs](http://github.com/ActiveState/appdirs) | 1.4.3 | python2_core |
| [appdirs](http://github.com/ActiveState/appdirs) | 1.4.3 | python3_core |
| [arrow](https://arrow.readthedocs.io/en/latest/) | 0.14.2 | python3 |
| [astroid](https://github.com/PyCQA/astroid) | 1.6.6 | python2_devtools |
| [astroid](https://github.com/PyCQA/astroid) | 2.2.5 | python3_devtools |
| [atomicwrites](https://github.com/untitaker/python-atomicwrites) | 1.3.0 | python2_devtools |
| [atomicwrites](https://github.com/untitaker/python-atomicwrites) | 1.3.0 | python3_devtools |
| [attrs](https://www.attrs.org/) | 19.1.0 | python2_devtools |
| [attrs](https://www.attrs.org/) | 19.1.0 | python3_devtools |
| [autopep8](https://github.com/hhatto/autopep8) | 1.4.4 | python3 |
| [backports.functools-lru-cache](https://github.com/jaraco/backports.functools_lru_cache) | 1.5 | python2 |
| [bash](https://github.com/alexcouper/bash) | 0.6 | python2 |
| [bash](https://github.com/alexcouper/bash) | 0.6 | python3 |
| [binaryornot](https://github.com/audreyr/binaryornot) | 0.4.4 | python3 |
| [black](https://github.com/ambv/black) | 19.3b0 | python3_devtools |
| [c-ares](https://c-ares.haxx.se/) | 1.12.0 | core |
| [cached-property](https://github.com/pydanny/cached-property) | 1.5.1 | python3_circus |
| [cachetools](https://github.com/tkem/cachetools) | 3.1.1 | python2 |
| [cachetools](https://github.com/tkem/cachetools) | 3.1.1 | python3 |
| [cairo](https://www.cairographics.org/) | 1.14.12 | scientific_core |
| [certifi](https://certifi.io/) | 2019.3.9 | monitoring |
| [certifi](https://certifi.io/) | 2019.3.9 | python2 |
| [certifi](https://certifi.io) | 2019.3.9 | python2_core |
| [certifi](https://certifi.io/) | 2019.3.9 | python2_devtools |
| [certifi](https://certifi.io/) | 2019.3.9 | python3 |
| [certifi](https://certifi.io/) | 2019.3.9 | python3_circus |
| [certifi](https://certifi.io) | 2019.3.9 | python3_core |
| [certifi](https://certifi.io/) | 2019.3.9 | python3_devtools |
| [cffi](http://cffi.readthedocs.org) | 1.12.3 | python2 |
| [cffi](http://cffi.readthedocs.org) | 1.12.3 | python3 |
| [chardet](https://github.com/chardet/chardet) | 3.0.4 | python2 |
| [chardet](https://github.com/chardet/chardet) | 3.0.4 | python3 |
| [circus-autorestart-plugin](https://pypi.org/project/circus-autorestart-plugin) | custom | python3_circus |
| [circus](https://pypi.org/project/circus) | custom | python3_circus |
| [ciso8601](https://github.com/closeio/ciso8601) | 2.1.1 | monitoring |
| [configparser-extended](https://github.com/thefab/configparser_extended) | custom | python2 |
| [configparser-extended](https://github.com/thefab/configparser_extended) | custom | python3 |
| [configparser](https://github.com/jaraco/configparser/) | 3.7.4 | python2 |
| [contextlib2](http://contextlib2.readthedocs.org) | 0.5.5 | python2_devtools |
| [cookiecutter-hooks](https://pypi.org/project/cookiecutter-hooks) | custom | python3 |
| [cookiecutter](https://github.com/audreyr/cookiecutter) | custom | python3 |
| [coverage](https://github.com/nedbat/coveragepy) | 4.5.4 | python2_devtools |
| [coverage](https://github.com/nedbat/coveragepy) | 4.5.4 | python3_devtools |
| [cronwrapper](https://github.com/thefab/cronwrapper) | custom | python3 |
| [ctags](http://ctags.sourceforge.net/) | 5.8 | core |
| [curl](https://curl.haxx.se/) | 7.65.1 | core |
| [db](http://www.oracle.com/technetwork/database/berkeleydb/overview/index.html) | 4.5.20 | rpm |
| [deploycron](https://github.com/monklof/deploycron) | custom | python2 |
| [deploycron](https://github.com/monklof/deploycron) | custom | python3 |
| [diskcache](http://www.grantjenks.com/docs/diskcache/) | 3.1.1 | python2 |
| [diskcache](http://www.grantjenks.com/docs/diskcache/) | 3.1.1 | python3 |
| [docutils](http://docutils.sourceforge.net/) | 0.15.2 | python3_devtools |
| [dtreetrawl](https://github.com/raamsri/dtreetrawl) | master20190715 | core |
| [elasticsearch](https://github.com/elastic/elasticsearch-py) | 6.4.0 | monitoring |
| [entrypoints](https://github.com/takluyver/entrypoints) | 0.3 | python2_devtools |
| [entrypoints](https://github.com/takluyver/entrypoints) | 0.3 | python3_devtools |
| [enum](https://pypi.org/project/enum/) | 0.4.7 | python2 |
| [enum34](https://bitbucket.org/stoneleaf/enum34) | 1.1.6 | python2_devtools |
| [envtpl](https://github.com/andreasjansson/envtpl) | custom | python2 |
| [envtpl](https://github.com/andreasjansson/envtpl) | custom | python3 |
| [filelock](https://github.com/benediktschmitt/py-filelock) | 3.0.12 | python2 |
| [filelock](https://github.com/benediktschmitt/py-filelock) | 3.0.12 | python3 |
| [flake8-docstrings](https://gitlab.com/pycqa/flake8-docstrings) | 1.3.1 | python2_devtools |
| [flake8-docstrings](https://gitlab.com/pycqa/flake8-docstrings) | 1.3.1 | python3_devtools |
| [flake8-polyfill](https://gitlab.com/pycqa/flake8-polyfill) | 1.0.2 | python2_devtools |
| [flake8-polyfill](https://gitlab.com/pycqa/flake8-polyfill) | 1.0.2 | python3_devtools |
| [flake8](https://gitlab.com/pycqa/flake8) | 3.7.8 | python2_devtools |
| [flake8](https://gitlab.com/pycqa/flake8) | 3.7.8 | python3_devtools |
| [funcsigs](http://funcsigs.readthedocs.org) | 1.0.2 | python2_devtools |
| [functools32](https://github.com/MiCHiLU/python-functools32) | 3.2.3.post2 | python2_devtools |
| [future](https://python-future.org) | 0.17.1 | python3 |
| [futures](https://github.com/agronholm/pythonfutures) | 3.3.0 | python2_devtools |
| [gdal](http://www.gdal.org) | 2.2.4 | scientific_core |
| [geos](http://trac.osgeo.org/geos/) | 3.7.1 | scientific_core |
| [gitignore-parser](https://github.com/mherrmann/gitignore_parser) | 0.0.4 | python3_circus |
| [glib](https://developer.gnome.org/glib/) | 2.56.4 | core |
| [graphviz](https://graphviz.org) | 2.40.1 | devtools |
| [hdf5](https://www.hdfgroup.org) | 1.10.2 | scientific_core |
| [idna](https://github.com/kjd/idna) | 2.8 | python2 |
| [idna](https://github.com/kjd/idna) | 2.8 | python3 |
| [imagesize](https://github.com/shibukawa/imagesize_py) | 1.1.0 | python3_devtools |
| [importlib-metadata](http://importlib-metadata.readthedocs.io/) | 0.19 | python2_devtools |
| [importlib-metadata](http://importlib-metadata.readthedocs.io/) | 0.19 | python3_devtools |
| [inotify-simple](https://github.com/chrisjbillington/inotify_simple) | 1.1.8 | python2 |
| [inotify-simple](https://github.com/chrisjbillington/inotify_simple) | 1.1.8 | python3 |
| [isort](https://github.com/timothycrosley/isort) | 4.3.21 | python2_devtools |
| [isort](https://github.com/timothycrosley/isort) | 4.3.21 | python3_devtools |
| [jasper](http://www.ece.uvic.ca/~frodo/jasper/) | 2.0.14 | scientific_core |
| [jinja2-time](https://github.com/hackebrot/jinja2-time) | 0.2.0 | python3 |
| [json-c](https://github.com/json-c/json-c) | 0.13.1-20180305 | core |
| [jsonlog2elasticsearch](https://pypi.org/project/jsonlog2elasticsearch) | custom | monitoring |
| [layerapi2](https://github.com/metwork-framework/layerapi2) | 0.0.2 | core |
| [lazy-object-proxy](https://github.com/ionelmc/python-lazy-object-proxy) | 1.4.2 | python2_devtools |
| [lazy-object-proxy](https://github.com/ionelmc/python-lazy-object-proxy) | 1.4.2 | python3_devtools |
| [libev](http://software.schmorp.de/pkg/libev.html) | 4.25 | core |
| [libffi](https://sourceware.org/libffi/) | 3.2 | core |
| [libpng](http://www.libpng.org/) | 1.6.37 | scientific_core |
| [libressl](https://www.libressl.org/) | 2.9.2 | core |
| [libspatialite](https://www.gaia-gis.it/fossil/libspatialite) | 4.3.0a | scientific_core |
| [libxml2](http://xmlsoft.org/) | 2.9.7 | core |
| [libxslt](http://xmlsoft.org/) | 1.1.28 | core |
| [liquidprompt](https://github.com/nojhan/liquidprompt) | v_1.11 | core |
| [lua-resty-cookie](https://github.com/cloudflare/lua-resty-cookie/) | master-20160630 | openresty |
| [lua-resty-http](https://github.com/pintsized/lua-resty-http) | master-20160530 | openresty |
| [lua-resty-statsd](https://github.com/metwork-framework/lua-resty-statsd) | 0.0.3 | openresty |
| [m2r](https://github.com/miyakogi/m2r) | 0.2.1 | python3_devtools |
| [mccabe](https://github.com/pycqa/mccabe) | 0.6.1 | python2_devtools |
| [mccabe](https://github.com/pycqa/mccabe) | 0.6.1 | python3_devtools |
| [mflog](https://pypi.org/project/mflog) | custom | python2 |
| [mflog](https://pypi.org/project/mflog) | custom | python3 |
| [mfutil_c](https://github.com/metwork-framework/mfutil_c) | 0.0.4 | core |
| [mfutil_lua](https://github.com/metwork-framework/mfutil_lua) | 0.0.1 | openresty |
| [mistune](https://github.com/lepture/mistune) | 0.8.4 | python3_devtools |
| [mock](http://mock.readthedocs.org/en/latest/) | 3.0.5 | python2_devtools |
| [mock](http://mock.readthedocs.org/en/latest/) | 3.0.5 | python3_devtools |
| [mockredispy](http://www.github.com/locationlabs/mockredis) | 2.9.3 | python2_devtools |
| [mockredispy](http://www.github.com/locationlabs/mockredis) | 2.9.3 | python3_devtools |
| [more-itertools](https://github.com/erikrose/more-itertools) | 5.0.0 | python2_devtools |
| [more-itertools](https://github.com/erikrose/more-itertools) | 7.2.0 | python3_devtools |
| [netcdf-c](http://www.unidata.ucar.edu/software/netcdf/) | 4.7.0 | scientific_core |
| [netcdf-cxx4](http://www.unidata.ucar.edu/software/netcdf/) | 4.3.0 | scientific_core |
| [netifaces](https://github.com/al45tair/netifaces) | 0.10.9 | python2 |
| [netifaces](https://github.com/al45tair/netifaces) | 0.10.9 | python3 |
| [nodejs](http://nodejs.org) | 10.16.0 | nodejs |
| [nose](http://readthedocs.org/docs/nose/) | 1.3.7 | python2_devtools |
| [nose](http://readthedocs.org/docs/nose/) | 1.3.7 | python3_devtools |
| [openjdk](https://jdk.java.net) | 11.0.2 | java |
| [openjpeg](http://www.openjpeg.org/) | 2.1.2 | scientific_core |
| [openresty](http://openresty.org) | 1.15.8.1 | openresty |
| [packaging](https://github.com/pypa/packaging) | 19.0 | python2_core |
| [packaging](https://github.com/pypa/packaging) | 19.0 | python3_core |
| [pathlib2](https://github.com/mcmtroffaes/pathlib2) | 2.3.4 | python2_devtools |
| [pcre](http://www.pcre.org) | 8.36 | core |
| [pip](https://pip.pypa.io/) | 9.0.3 | python2_core |
| [pip](https://pip.pypa.io/) | 18.1 | python3_core |
| [pluggy](https://github.com/pytest-dev/pluggy) | 0.12.0 | python2_devtools |
| [pluggy](https://github.com/pytest-dev/pluggy) | 0.12.0 | python3_devtools |
| [postgis](http://postgis.refractions.net/) | 2.4.6 | scientific_core |
| [postgresql](http://postgresql.org/) | 10.1 | scientific_core |
| [poyo](https://github.com/hackebrot/poyo) | 0.4.2 | python3 |
| [proj](http://trac.osgeo.org/proj/) | 5.2.0 | scientific_core |
| [psutil](https://github.com/giampaolo/psutil) | 5.6.3 | python2 |
| [psutil](https://github.com/giampaolo/psutil) | 5.6.3 | python3 |
| [py](http://py.readthedocs.io/) | 1.8.0 | python2_devtools |
| [py](http://py.readthedocs.io/) | 1.8.0 | python3_devtools |
| [pycodestyle](https://pycodestyle.readthedocs.io/) | 2.5.0 | python2_devtools |
| [pycodestyle](https://pycodestyle.readthedocs.io/) | 2.5.0 | python3 |
| [pycparser](https://github.com/eliben/pycparser) | 2.19 | python2 |
| [pycparser](https://github.com/eliben/pycparser) | 2.19 | python3 |
| [pydocstyle](https://github.com/PyCQA/pydocstyle/) | 3.0.0 | python2_devtools |
| [pydocstyle](https://github.com/PyCQA/pydocstyle/) | 4.0.1 | python3_devtools |
| [pyflakes](https://github.com/PyCQA/pyflakes) | 2.1.1 | python2_devtools |
| [pyflakes](https://github.com/PyCQA/pyflakes) | 2.1.1 | python3_devtools |
| [pygtail](http://github.com/bgreenlee/pygtail) | 0.10.1 | monitoring |
| [pyinotify](http://github.com/seb-m/pyinotify) | 0.9.6 | python3 |
| [pylint](https://github.com/PyCQA/pylint) | 1.9.5 | python2_devtools |
| [pylint](https://github.com/PyCQA/pylint) | 2.3.1 | python3_devtools |
| [pyparsing](http://pyparsing.wikispaces.com/) | 2.4.0 | python2_core |
| [pyparsing](http://pyparsing.wikispaces.com/) | 2.4.0 | python3_core |
| [pytest](https://docs.pytest.org/en/latest/) | 4.6.5 | python2_devtools |
| [pytest](https://docs.pytest.org/en/latest/) | 5.1.1 | python3_devtools |
| [python-dateutil](https://dateutil.readthedocs.io) | 2.8.0 | python3 |
| [pytz](http://pythonhosted.org/pytz) | 2019.1 | python3 |
| [pyzmq](https://pyzmq.readthedocs.org) | 16.0.4 | python3_circus |
| [readline](https://www.gnu.org/software/readline) | 8.0 | core |
| [redis](http://redis.io) | 5.0.5 | core |
| [redis](https://github.com/andymccurdy/redis-py) | 3.2.1 | python2 |
| [redis](https://github.com/andymccurdy/redis-py) | 3.2.1 | python3 |
| [requests-toolbelt](https://toolbelt.readthedocs.org) | 0.9.1 | python2 |
| [requests-toolbelt](https://toolbelt.readthedocs.org) | 0.9.1 | python3 |
| [requests](http://python-requests.org) | 2.22.0 | python2 |
| [requests](http://python-requests.org) | 2.22.0 | python3 |
| [rpm](http://rpm.org) | 4.9.1.3 | rpm |
| [scandir](https://github.com/benhoyt/scandir) | 1.10.0 | python2_devtools |
| [setuptools-scm](https://github.com/pypa/setuptools_scm/) | 3.3.3 | python2 |
| [setuptools-scm](https://github.com/pypa/setuptools_scm/) | 3.3.3 | python3 |
| [setuptools](https://pypi.python.org/pypi/setuptools) | 41.0.1 | python2_core |
| [setuptools](https://pypi.python.org/pypi/setuptools) | 41.0.1 | python3_core |
| [shellcheck](http://www.shellcheck.net) | 20170801 | devtools |
| [singledispatch](http://docs.python.org/3/library/functools.html#functools.singledispatch) | 3.4.0.3 | python2_devtools |
| [six](https://pypi.python.org/pypi/six/) | 1.12.0 | python2_core |
| [six](https://pypi.python.org/pypi/six/) | 1.12.0 | python3_core |
| [sloccount](https://www.dwheeler.com/sloccount/) | 2.26 | devtools |
| [snowballstemmer](https://github.com/snowballstem/snowball) | 1.9.0 | python2_devtools |
| [snowballstemmer](https://github.com/snowballstem/snowball) | 1.9.0 | python3_devtools |
| [sphinx-automodapi](http://astropy.org) | 0.12 | python3_devtools |
| [sphinx-rtd-theme](https://github.com/rtfd/sphinx_rtd_theme/) | 0.4.3 | python3_devtools |
| [sphinxcontrib-applehelp](None) | 1.0.1 | python3_devtools |
| [sphinxcontrib-devhelp](None) | 1.0.1 | python3_devtools |
| [sphinxcontrib-htmlhelp](None) | 1.0.2 | python3_devtools |
| [sphinxcontrib-jsmath](http://sphinx-doc.org/) | 1.0.1 | python3_devtools |
| [sphinxcontrib-qthelp](None) | 1.0.2 | python3_devtools |
| [sphinxcontrib-serializinghtml](None) | 1.1.3 | python3_devtools |
| [sqlite](http://sqlite.org/) | 3080803 | core |
| [statsd](https://github.com/jsocol/pystatsd) | custom | python2 |
| [statsd](https://github.com/jsocol/pystatsd) | custom | python3 |
| [structlog](https://www.structlog.org/) | 19.1.0 | python2 |
| [structlog](https://www.structlog.org/) | 19.1.0 | python3 |
| [tcl](https://www.tcl.tk/) | 8.6.9 | tcltk |
| [tcping](http://linuxco.de) | 1.3.5 | core |
| [telegraf-unixsocket-client](https://github.com/metwork-framework/telegraf-unixsocket-python-client) | custom | python3 |
| [telegraf](https://github.com/influxdata/telegraf) | 1.11.2-1 | monitoring |
| [terminaltables](https://github.com/Robpol86/terminaltables) | 3.1.0 | python2 |
| [terminaltables](https://github.com/Robpol86/terminaltables) | 3.1.0 | python3 |
| [testfixtures](https://github.com/Simplistix/testfixtures) | 6.10.0 | python2_devtools |
| [testfixtures](https://github.com/Simplistix/testfixtures) | 6.10.0 | python3_devtools |
| [tk](https://www.tcl.tk/) | 8.6.9.1 | tcltk |
| [toml](https://github.com/uiri/toml) | 0.10.0 | python3_devtools |
| [tornado](http://www.tornadoweb.org/) | 4.5.2 | python3_circus |
| [typed-ast](https://github.com/python/typed_ast) | 1.4.0 | python3_devtools |
| [typing](https://docs.python.org/3/library/typing.html) | 3.7.4.1 | python2_devtools |
| [ujson](http://www.esn.me) | 1.35 | monitoring |
| [urllib3](https://urllib3.readthedocs.io/) | 1.25.3 | python2 |
| [urllib3](https://urllib3.readthedocs.io/) | 1.25.3 | python3 |
| [virtualenv](https://virtualenv.pypa.io/) | 16.6.0 | python2_core |
| [virtualenv](https://virtualenv.pypa.io/) | 16.6.0 | python3_core |
| [wcwidth](https://github.com/jquast/wcwidth) | 0.1.7 | python2_devtools |
| [wcwidth](https://github.com/jquast/wcwidth) | 0.1.7 | python3_devtools |
| [wheel](https://github.com/pypa/wheel) | 0.33.4 | python2_core |
| [wheel](https://github.com/pypa/wheel) | 0.33.4 | python3_core |
| [whichcraft](https://github.com/pydanny/whichcraft) | 0.5.2 | python3 |
| [wrapt](https://github.com/GrahamDumpleton/wrapt) | 1.11.2 | python2_devtools |
| [wrapt](https://github.com/GrahamDumpleton/wrapt) | 1.11.2 | python3_devtools |
| [yajl](https://lloyd.github.io/yajl/) | 2.1.0 | core |
| [zipp](https://github.com/jaraco/zipp) | 0.6.0 | python2_devtools |
| [zipp](https://github.com/jaraco/zipp) | 0.6.0 | python3_devtools |

*(246 components)*








## 5. Reference documentation

- (for **master (development)** version), see [this dedicated site](http://metwork-framework.org/pub/metwork/continuous_integration/docs/master/mfext/) for reference documentation.
- (for **latest released stable** version), see [this dedicated site](http://metwork-framework.org/pub/metwork/releases/docs/stable/mfext/) for reference documentation.

For very specific use cases, you might be interested in
[reference documentation for integration branch](http://metwork-framework.org/pub/metwork/continuous_integration/docs/integration/mfext/).

And if you are looking for an old released version, you can search [here](http://metwork-framework.org/pub/metwork/releases/docs/).



## 6. Installation guide

See [this document](.metwork-framework/install_a_metwork_package.md).




## 7. Contributing guide

See [CONTRIBUTING.md](CONTRIBUTING.md) file.



## 8. Code of Conduct

See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) file.



## 9. Sponsors

*(If you are officially paid to work on MetWork Framework, please contact us to add your company logo here!)*

[![logo](https://raw.githubusercontent.com/metwork-framework/resources/master/sponsors/meteofrance-small.jpeg)](http://www.meteofrance.com)
