.. index:: layerapi2
# Layerapi2

## General

The [layerapi2](https://github.com/metwork-framework/layerapi2) library is
the heart of `mfext` layers system.

You should read the [layerapi2 reference documentation](https://github.com/metwork-framework/layerapi2/blob/master/README.md).

## How we use layerapi2 in MetWork

### Layer names

We use the following convention for layer names:

    name@module_name_in_lowercase

For example: `python3@mfserv`.

### `LAYERAPI2_LAYERS_PATH`

First of all, we set in `LAYERAPI2_LAYERS_PATH`:

- `${MFEXT_HOME}`
- `${MFEXT_HOME}/opt`
- `${MFMODULE_HOME}` (if the current module is not `mfext`)
- `${MFMODULE_HOME}/opt` (if the current module is not `mfext`)
- `${MFMODULE_RUNTIME_HOME}/var/plugins` (if the current module is `mfserv`, `mfbase` or `mfdata`)

So we have a kind of layers inheritance. For example: `mfserv => mfext`.

### Special layers

In each module, we have two special layers:

- `root@module_name_in_lowercase` (example: `root@mfext`)
- `default@module_name_in_lowercase`) (example: `default@mfdata`)

The first one is special because of its "layer home" (see next paragraph). And the
second is mainly an empty layer with dependencies. This layer is loaded
by default when you "source" the corresponding module (or when you log in as `mfxxx` user).

So this "default" layer is used to select (with its dependencies) which layers are
loaded by default (have a look at its `.layerapi2_dependencies` file).

In `mfserv`, `mfdata` and `mfbase` modules, we have some other special layers:

    `plugin_foo@module_name_in_lowercase`

For user-provided plugins (which are regular layers but with a custom "layer_home" (see next
paragraph).

### Layer homes

The layer home of `foo@mfserv` (for example) is always:

    ${MFSERV_HOME}/opt/foo

There are two exceptions:

- one for `root@module_name_in_lowercase` (see "special layers") (for this one,
its layer home is : `${MFMODULE_HOME}`)
- one for `plugin_foo@module_name_in_lowercase` (see "special layers") (for these layers,
their layer home is `${MFMODULE_RUNTIME_HOME}/var/plugins/foo`)


### Real example

When we log in as `mfserv` on a machine with a lot of layers, you can have something like this:

```console
$ layers

- plugin_welcome@mfserv [/home/fab/metwork/mfserv/var/plugins/welcome]
- (*) default@mfserv [/home/fab/metwork/mfserv/build/opt/default]
- python2@mfserv [/home/fab/metwork/mfserv/build/opt/python2]
- nodejs@mfserv [/home/fab/metwork/mfserv/build/opt/nodejs]
- (*) python3@mfserv [/home/fab/metwork/mfserv/build/opt/python3]
- (*) root@mfserv [/home/fab/metwork/mfserv/build]
- (*) misc@mfext [/home/fab/metwork/mfext/build/opt/misc]
- python2_misc@mfext [/home/fab/metwork/mfext/build/opt/python2_misc]
- (*) python3_misc@mfext [/home/fab/metwork/mfext/build/opt/python3_misc]
- (*) python3_vim@mfext [/home/fab/metwork/mfext/build/opt/python3_vim]
- rpm@mfext [/home/fab/metwork/mfext/build/opt/rpm]
- python2_devtools@mfext [/home/fab/metwork/mfext/build/opt/python2_devtools]
- (*) core@mfext [/home/fab/metwork/mfext/build/opt/core]
- (*) tcltk@mfext [/home/fab/metwork/mfext/build/opt/tcltk]
- (*) default@mfext [/home/fab/metwork/mfext/build/opt/default]
- (*) devtools@mfext [/home/fab/metwork/mfext/build/opt/devtools]
- (*) openresty@mfext [/home/fab/metwork/mfext/build/opt/openresty]
- python2@mfext [/home/fab/metwork/mfext/build/opt/python2]
- (*) nodejs@mfext [/home/fab/metwork/mfext/build/opt/nodejs]
- (*) python3_core@mfext [/home/fab/metwork/mfext/build/opt/python3_core]
- python2_core@mfext [/home/fab/metwork/mfext/build/opt/python2_core]
- (*) scientific_core@mfext [/home/fab/metwork/mfext/build/opt/scientific_core]
- (*) python3_devtools@mfext [/home/fab/metwork/mfext/build/opt/python3_devtools]
- python3_circus@mfext [/home/fab/metwork/mfext/build/opt/python3_circus]
- (*) monitoring@mfext [/home/fab/metwork/mfext/build/opt/monitoring]
- python2_vim@mfext [/home/fab/metwork/mfext/build/opt/python2_vim]
- (*) python3@mfext [/home/fab/metwork/mfext/build/opt/python3]
- (*) java@mfext [/home/fab/metwork/mfext/build/opt/java]
- (*) vim@mfext [/home/fab/metwork/mfext/build/opt/vim]
- (*) root@mfext [/home/fab/metwork/mfext/build]
```

Note: you have (*) before the layer label if the corresponding layer is already loaded

We can see various layers of various modules installed. A lot of them are loaded.
You can also see a `mfserv` plugins (of course not loaded).

### Tools

Have a look at [layerapi2 reference documentation](https://github.com/metwork-framework/layerapi2/blob/master/README.md) for details but main tools available around layer system are:

#### layers

```none
{{ "layers --help"|shell }}
```

#### is_layer_installed, is_layer_loaded

```none
{{ "is_layer_installed --help"|shell }}
```

```none
{{ "is_layer_loaded --help"|shell }}
```

#### layer_wrapper

```none
{{ "layer_wrapper --help"|shell }}
```


#### layer_load, layer_unload

`layer_load` and `layer_unload` are two bash functions to load or unload
an installed layer.

For example:

```none
layer_load python2@mfext
```
