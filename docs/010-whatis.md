# What is MFEXT ?

**MFEXT** is a "dependencies package" ridiculously easy to install which adds plenty of recent software components to a Linux distribution, especially for scientific and meteorology domain, but not only!

**MFEXT** is "language agnostic" and runs on plenty of linux distributions from a venerable CentOS6 to the latest Fedora or openSUSE where it brings to you exactly the same [list of component versions]({{components}}).

In 5 seconds, here is how **MFEXT** works:

```console
$ # What python version do I have?
$ python --version
Python 2.7.5
$ # This is an old version!

$ # Load a mfext profile for the current session
$ . /opt/metwork-mfext/share/interactive_profile

$ # Now we have loaded the profile, test the python version again
$ python --version
Python 3.7.3
$ # Great, a newer version!
```

!!! success ""
    Installing the **MFEXT** module is really safe, it **can't break anything on your system**. It does not contain any services, it is just a bunch of files and directories installed in `/opt` directory and you have to **explicitly** load a profile file to use them.

**MFEXT** is the **M**etwork **F**ramework "**EXT**ernal dependencies" **module**. It can be used alone, or as a dependency of other MetWork Framework **modules** (like [mfserv](https://github.com/metwork-framework/mfserv) or [mfdata](https://github.com/metwork-framework.org/mfdata)).

!!! info "MetWork Framework?"
    [MetWork Framework](http://www.metwork-framework.org) is an open source system for building and managing production grade applications or micro-services.

Here is a "30 seconds screencast" showcasing installation and (really) basic usage of **MFEXT**:

[![asciicast](https://asciinema.org/a/uNsG6AaPkMeZ3Lb8NsW4vMkYa.png)](https://asciinema.org/a/uNsG6AaPkMeZ3Lb8NsW4vMkYa)
