[![logo](https://raw.githubusercontent.com/metwork-framework/resources/master/logos/metwork-white-logo-small.png)](http://www.metwork-framework.org)
# mfext

[//]: # (automatically generated from https://github.com/metwork-framework/resources/blob/master/cookiecutter/_%7B%7Bcookiecutter.repo%7D%7D/README.md)

## Status (master branch)
[![Drone CI](http://metwork-framework.org:8000/api/badges/metwork-framework/mfext/status.svg)](http://metwork-framework.org:8000/metwork-framework/mfext)
[![Maintenance](https://github.com/metwork-framework/resources/blob/master/badges/maintained.svg)]()
[![License](https://github.com/metwork-framework/resources/blob/master/badges/bsd.svg)]()
[![Gitter](https://github.com/metwork-framework/resources/blob/master/badges/community-en.svg)](https://gitter.im/metwork-framework/community-en?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
[![Gitter](https://github.com/metwork-framework/resources/blob/master/badges/community-fr.svg)](https://gitter.im/metwork-framework/community-fr?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)


## What is MFEXT ?

This is the **M**etwork **F**ramework "**EXT**ernal depencies" module. This module does not contain any services, it is just a bunch of files and directories.

MFEXT is staged in logical and/or technical *layers*. You may check :doc:`../layerapi2` documentation for more about *layers* concept and technical details.

The available libraries and sets of tools in MFEXT can be found by ckecking 
the documentation about layers or the :ref:`genindex`, or by using the search box.
<div role="search">
  <form id="rtd-search-form" class="wy-form" action="search.html" method="get">
    <input type="text" name="q" placeholder="Search docs" />
    <input type="hidden" name="check_keywords" value="yes" />
    <input type="hidden" name="area" value="default" />
    <button type="submit"><i class="fa fa-search"></i></button>
  </form>
</div>

_ _ _

Some libraries and sets of tools are not included in MFEXT but provided as **MFEXT add-ons**. They have to be installed appart. Available MFEXT add-ons can be found [here](https://github.com/metwork-framework?utf8=%E2%9C%93&q=mfext-addon&type=&language=).

## Usage

### General

After installation, there is no service to initialize or to start.

All the files are located in `/opt/metwork-mfext-{BRANCH}` directory with probably
a `/opt/metwork-mfext => /opt/metwork-mfext-{BRANCH}` symbolic link (depending
on what you have installed).

Because `/opt` is not used by default on [standard Linux](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard), the installation shouldn't break anything.

Therefore, if you do nothing specific after the installation, you won't benefit
from any included software packages !

So, to use this module, you have to load a kind of "metwork environment". There are several ways to do that.

In the following, we use `{MFEXT_HOME}` as the installation directory of the `mfext` module. It's probably something like `/opt/metwork-mfext-{BRANCH}` or `/opt/metwork-mfext`. Have a look in `/opt` directory.

### Usage (for one command only)

If you want to load the "mfext environment" for one command only and return back to a standard running environment after that, you can use the specific wrapper:

```
##### Shell session example #####

# where is the system python command ?
$ which python
/usr/bin/python
# => this is the standard/system python command (in /usr/bin)

# what is the version of the system python command ?
$ python --version
Python 2.6.6
# => this is a very old python version

# execute python through the wrapper
# (please replace {MFEXT_HOME} by the real mfext home !)
$ {MFEXT_HOME}/bin/mfext_wrapper which python
/opt/metwork[...]/bin/python
# => this is the metwork python command included in this module

# what is the version of the mfext python command ?
$ {MFEXT_HOME}/bin/mfext_wrapper python --version
Python 3.5.3
# => this is a recent python version
```

### Usage (for the whole shell session)

If you are tired to use `mfext_wrapper` repeatedly, you can load the "mfext environment"
for the whole shell session.

Note: at this moment, it doesn't seem to play very well with `zsh` (see #62)


```
##### Shell session example #####

# where is the system python command ?
$ which python
/usr/bin/python
# => this is the standard/system python command (in /usr/bin)

# what is the version of the system python command ?
$ python --version
Python 2.6.6
# => this is a very old python version

# load the mfext environment for the whole shell session
$ source {MFEXT_HOME}/share/interative_profile
           __  __      ___          __        _
          |  \/  |    | \ \        / /       | |
          | \  / | ___| |\ \  /\  / /__  _ __| | __
          | |\/| |/ _ \ __\ \/  \/ / _ \| '__| |/ /
          | |  | |  __/ |_ \  /\  / (_) | |  |   <
          |_|  |_|\___|\__| \/  \/ \___/|_|  |_|\_\


 17:01:04 up 19 days,  5:22,  1 user,  load average: 0.75, 0.71, 0.45

# => the interactive environment is loaded

# where is the default python command
$ which python
/opt/metwork[...]/bin/python
# => this is the metwork python command included in this module

# what is the version of the default python command ?
$ python --version
Python 3.5.3
# => this is a recent python version
```

Note: if you want to do that but in a non-interactive shell, you should use
`source {MFEXT_HOME}/share/profile` instead.

### Usage (automatically for one user)

If you want to have a system user with "always loaded" metwork environment, you can add:

```
source {MFEXT_HOME}/share/interactive_profile
```

in (for example) in the user `.bash_profile` file.

Note: we do not recommend to use this for a user with a full graphical interface because of possible side effects with desktop environment.

An alternative way is to add

```
alias mfext="source {MFEXT_HOME}/share/interactive_profile"
```

in `.bash_profile` file and use this `mfext` alias when you want to quickly load the "mfext environment".



## Installation guide

See [this document](.metwork-framework/install_a_metwork_package.md).




## Contributing guide

See [CONTRIBUTING.md](CONTRIBUTING.md) file.



## Code of Conduct

See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) file.


