.. index:: layerapi2
# Layerapi2

## Overview

`layerapi2` module is a library and a set of cli tools to manage a layered environment
system.

A similar system is [environment modules](http://modules.sourceforge.net/). `layerapi2` module
is more simple, probably more opinionated and reliable but less HPC oriented and deals with only one
compiler.

The library is designed to be not Metwork specific and should be released
as an independent product.

## Main concepts

.. index:: layer concept
### A layer

A layer is defined by:

- a layer label (a string, not necessarily unique)
- a layer home (a full path to a directory)

Optionally, a layer definition can include:

- some dependencies (just a list of other layer labels)
- some conflicts (just a list of other layer labels)
- some environment variables to set/unset during layer load/unload
- some extra interactive profile to load/unload during layer load/unload

So concretely, a layer is a directory with the following structure:

```none
    /path/to/my/layer/
                     /.layerapi2_label
                     /.layerapi2_dependencies
                     /.layerapi2_conflicts
                     /.layerapi2_extra_env
                     /.layerapi2_interactive_profile
                     /.layerapi2_interactive_unprofile
```

The only mandatory file is `.layerapi2_label`. It contains the layer label on its first and
only line.

.. index:: layer path
### A layers path

The environment variable `METWORK_LAYERS_PATH` contains a ":" separated list
of directories full paths.

When we search a given layer, we iterate the list from the beginning and for each
directory full path, we test:

- if the selected directory is a layer by itself (ie. it contains a `.layerapi2_label` file)
- if immediate subdirectories are layers

Consider the following example:

```none
    /path1/layer1/
    /path1/layer1/.layerapi2_label (containing "layer1label")
    /path2/layers/
    /path2/layers/layer2/
    /path2/layers/layer2/.layerapi2_label (containing "layer2label")
    /path3/layers/layer3/
    /path3/layers/layer3/.layerapi2_label (containing "layer3label")
```

If the value of `METWORK_LAYERS_PATH` is `/path1/layer1:/path2/layers:/path3`:

- we will find (by its label) the layer "layer1label" because it's directly pointed
by the `/path1/layer1` value
- we will find (by its label) the layer "layer2label" because `/path2/layers/layer2` (its home)
is an immediate subdirectory of the `/path2/layers` value
- we won't find (by its label) the layer "layer3label" because `/path3/layers/layer3` (is home) is not an immediate subdirectory of the `/path3` value

Notes:

- relative paths in `METWORK_LAYERS_PATH` are ignored
- if there are several layer homes for a given label (ie. multiple directories with the same value for `.layerapi2_label` file),
the first occurrence is returned when searching by label
(so the order of entries in METWORK_LAYERS_PATH can be important).

.. index:: layer installation, layer loading, layer unloading,
### Installation / Loading / Unloading

We consider that a layer is *installed* if we can found it by its label through the layers path.

When a layer is *installed*, nothing is done automatically. It's just available for loading.

Then a layer can be loaded. When the layer is loaded, the environment is modified. We will see
that in more detail a little further.

When a layer is loaded, it can be unloaded. Then, the corresponding environment modification is reversed.

## Technical details

### What is done during layer loading ?

When you load a layer, following actions are done (in this particular order):

- first if the layer is already loaded, we do nothing more
- we iterate in the "conflicts list" of the layer and we unload each referenced layer (if loaded)
- we iterate in the "dependencies list" of the layer and we load each referenced layer (if not loaded)
- if a dependent layer is not installed (so it can't be loaded), we give up the layer loading (unless this particular dependency is marked as optional)
- then we load concretely the layer (we modify the current environment)

Following modifications are done to the current environment:

- we prepend to `PATH`: `{LAYER_HOME}/local/bin` and `{LAYER_HOME}/bin` (if corresponding directories exist)
- we prepend to `LD_LIBRARY_PATH`: `{LAYER_HOME}/local/lib` and {LAYER_HOME}/lib` (if corresponding directories exist)
- we prepend to `PKG_CONFIG_PATH`: `{LAYER_HOME}/local/lib/pkgconfig` and `{LAYER_HOME}/lib/pkgconfig` (if corresponding directories exist)
- we prepend to `PYTHONPATH`: `{LAYER_HOME}/local/lib/python{PYTHON2_SHORT_VERSION}/site-packages` and `{LAYER_HOME}/lib/python{PYTHON2_SHORT_VERSION}/site-packages` (if corresponding directories exist)
- we prepend to `PYTHONPATH`: `{LAYER_HOME}/local/lib/python{PYTHON3_SHORT_VERSION}/site-packages` and `{LAYER_HOME}/lib/python{PYTHON3_SHORT_VERSION}/site-packages` (if corresponding directories exist)
- we add extra environment variables listed by `{LAYER_HOME}/.layerapi2_extra_env` (if the file exists)
- we load/source the bash file `{LAYER_HOME}/.layerapi2_interactive_profile` file for interactive usage only (if the file exists)
- we set a special environment variable `METWORK_LAYER_{HASH}_LOADED` to memorize that the layer is loaded (`HASH` is a hash of the full layer home).

### What is done during layer unloading ?

When you unload a layer, following actions are done (in this particular order):

- we remove from `PATH`, `LD_LIBRARY_PATH`, `PKG_CONFIG_PATH`, `PYTHONPATH` all paths
which starts with `{LAYER_HOME}/`
- we load/source the bash file `{LAYER_HOME}/.layerapi2_interactive_unprofile` file for
interactive usage only (if the file exists)
- we unset the special environment variable `METWORK_LAYER_{HASH}_LOADED` to memorize that
the layer is not loaded any more
- we remove extra environment variables listed in `{LAYER_HOME}/.layerapi2_extra_env` (if the file exist)
- we (recursively) unload all layers which depends on this one

.. index:: layerapi2 syntax
.. _layerapi2_syntax:
### Syntax of `.layerapi2_*` files

#### General

all files are plain text files and must be located exactly in the layer home. We will
use `{LAYER_HOME}` syntax to point out this layer home in the following.

.. note::
   In all `.layerapi2_*` files, you can embed this particular syntax:
   `{environment_VARIABLE_NAME}` (with opening/closing braces), it will
   be dynamically substituted by its value (at loading time).

.. warning::
   Do not mix with `{LAYER_HOME}` which is just a syntax for this documentation.

.. index:: layerapi2_label
#### `{LAYER_HOME}/.layerapi2_label`

The only mandatory file is `layerapi2_label`. It is a plain text file with just one line
containing the layer label. Valid characters for layer labels are:

- basic letters of the English alphabet (A through Z and a through z)
- digits (0 though 9)
- space (but not at the beginning or at the end)
- following characters: `% & + , - . : = _ @` (but not at the beginning or at the end)

Example of `.layerapi2_label` file:

```none
valid_label_for_a_layer
```

.. index:: layerapi2_dependencies, layerapi2_conflicts
#### `{LAYER_HOME}/.layerapi2_dependencies` and `{LAYER_HOME}/.layerapi2_conflicts`

Then you have `layerapi2_dependencies` and `layerapi2_conflicts` which follow the same syntax.
They are plain text files with each line is another valid layer label (see restrictions about layer names above).

Example of `.layerapi2_dependencies`/`.layerapi2_conflicts` file:

```none
label of layer1
layer2_label
valid_label_for_a_layer
-optional_dependency1
-optional_dependency2
```

.. note::
    If the label starts with `-`, it means that it is an optional dependency.

.. index:: layerapi2_extra_env
#### `{LAYER_HOME}/.layerapi2_extra_env`

The  ̀.layerapi2_extra_env` is different. It's a plain text files with several lines:

- spaces at the beginning/end of each lines are ignored
- lines which start with `#` are comments (they do nothing)
- empty lines are ignored
- `ENV_VAR=ENV_VALUE` lines mean "set ENV_VALUE into environment variable named ENV_VAR" (no escaping is done, youd don't need quotation marks, the `=` character just delimits the variable name and its value)

Example of `.layerapi2_extra_env` file:

```none
PYTHON={MFEXT_HOME}/opt/python3_core/bin/python3
METWORK_PYTHON_MODE=3
PYTHON_SHORT_VERSION={PYTHON3_SHORT_VERSION}
PYTHONUNBUFFERED=x
```

.. note::
   In this file, you have an example of `{environment_VARIABLE_NAME}` syntax
   usage (see above).

.. index:: layerapi2_interactive_profile, layerapi2_interactive_unprofile
#### `{LAYER_HOME}/.layerapi2_interactive_profile` and `{LAYER_HOME}/.layerapi2_interactive_unprofile`

The `.layerapi2_interactive_profile` and `.layerapi2_interactive_unprofile` are plain `bash` files. The first one is sourced/loaded when the corresponding layer is loaded. But it works
only in interactive mode. For example, it won't work with `layer_wrapper` very important utility.

.. warning::
   These files should be removed in a future version of `layerapi2` and replaced by another
   system/syntax. The main reason is that we can't be sure that the
   `.layerapi2_interactive_unprofile` revert what the `.layerapi2_interactive_profile`
   has changed.

**Because of above warning, please don't use this feature a lot and limit bash commands to only
set aliases for interactive usage.**

.. index:: layerapi2 utilities
### Utilities

.. index:: layers
#### `layers`

The `layers` utility list installed layers. You can also filter the output to get:

- only loaded layers
- only not loaded (but installed) layers

If you don't see your layer in `layers` output, check your `METWORK_LAYERS_PATH` environment
variable and if there is a `.layerapi_label` in your layer home.

Full documentation:

```none
{{ "layers --help"|shell }}
```

In the default output:

- you have the layer label, then the layer home
- you have `(*)` before the layer label if the corresponding layer is already loaded

You can also filter only "not loaded" (but installed) layers with the following call:

```none
layers --loaded-filter=no
```
.. index:: is_layer_installed, is_layer_loaded
#### `is_layer_installed`, `is_layer_loaded`

These two little utilities output `1` is the layer given as argument is installed/loaded.

```none
{{ "is_layer_installed --help"|shell }}
```

```none
{{ "is_layer_loaded --help"|shell }}
```

.. index:: bootstrap_layer.sh
#### `bootstrap_layer.sh`

This little utility can be used to bootstrap an empty layer.

Details are given in the help message:

```none
{{ "bootstrap_layer.sh --help"|shell }}
```

.. index:: layer_wrapper
#### `layer_wrapper`

This is probably the most interesting and the most useful utility.

First, let's have a look at full options:

```none
{{ "layer_wrapper --help"|shell }}
```

This command can be used to launch another command in a new process but within a context
where some additional layers are loaded. The original context won't be modified.

For example:

```none
$ is_layer_loaded foo
0
    => The layer "foo" is not loaded


$ layer_wrapper --layers=foo -- is_layer_loaded foo
1
    => We launched "is_layer_loaded foo" in a new process/context
       within the layer "foo" is loaded


$ is_layer_loaded foo
0
    => The original context is not modified
```

Another more complex example:

```none
$ layers
- (*) layer1 [/tests/layer1]
- layer2 [/tests/layer2]
- layer3 [/tests/layer3]
    => We have 3 layers installed, only the first one is loaded

$ layer_wrapper --debug --empty --layers=layer2,layer3 -- layers
[DEBUG]: unloading layer1[/tests/layer1]
[DEBUG]: loading layer2[/tests/layer2]
[DEBUG]: loading layer3[/tests/layer3]
- layer1 [/tests/layer1]
- (*) layer2 [/tests/layer2]
- (*) layer3 [/tests/layer3]
    => We launched the "layers" command in a new context with first all layers
       unloaded then layer2 and layer3 loaded

$ layers
- (*) layer1 [/tests/layer1]
- layer2 [/tests/layer2]
- layer3 [/tests/layer3]
    => the original context is not modified
```

.. index:: layer_load_bash_cmds, layer_unload_bash_cmds
#### `layer_load_bash_cmds`, `layer_unload_bash_cmds`

Two very important utilities are `layer_load_bash_cmds` and `layer_unload_bash_cmds`.

They output bash commands to source/eval in order to change the current context with the given
layer loaded/unloaded (included all dependencies management).

```none
{{ "layer_load_bash_cmds --help"|shell }}
```

```none
{{ "layer_unload_bash_cmds --help"|shell }}
```

We recommend to define in your bash environment two bash functions like this:

```bash
    function layer_load() {
        eval "$(layer_load_bash_cmds --debug "$1")"
    }

    function layer_unload() {
        eval "$(layer_unload_bash_cmds --debug "$1")"
    }

    # Note: you can of course remove the "--debug" string if you don't want it
```

And use these two bash functions instead of `layer_load_bash_cmds`, `layer_unload_bash_cmds`
binaries directly. See full tutorial for more details.

.. index:: layerapi2 tutorial
## Full tutorial

{% include 'tutorial_layerapi2.mdtemp' %}
