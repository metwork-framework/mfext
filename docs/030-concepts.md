# Concepts

## Layers

**MFEXT** is staged in logical and/or technical **layers**. Some of them are optional,
you can choose not to install them (for example, layers about Python2). Each layer contains
one or several **components**.

For example, here are some **layers** hosted on this repository:

- `python3_core` which contains several core **components** for Python3: `python3`, `pip`, `virtualenv`...
- `python3` which contains several additional **components** for Python3: `requests`, `psutil`, `filelock`...
- `openresty` which contains: `openresty`, `lua_restry_http`, `lua_resty_cookie`... **components**
- `nodejs` which contains only one package: `nodejs`
- [...]

You can inspect installed layers with the {{link_utility("layers")}} utility.

!!! note
    If you want more details about the "layers system", please read the [corresponding documentation about layerapi2](../200-layerapi2).

## Components

Most of theses **components** are not
maintained by the MetWork Framework team. For example, you will find inside a recent [Python](http://www.python.org) interpreter or some well known libraries like [CURL](https://curl.haxx.se/) or [GLIB2](https://developer.gnome.org/glib/).

You can inspect installed components with the {{link_utility("components")}} utility.

## Add-ons

This repository holds a lot of **layers** but you will also find extra **layers** in **MFEXT addons**
repositories. Let's mention in particular [mfextaddon_scientific](https://github.com/metwork-framework/mfextaddon_scientific) which provides some **layers** with a lot of geospatial and
scientific tools.

An add-on to **MFEXT** can be maintained by anyone and can be hosted anywhere. But there are also some *officially maintained* add-ons and you can use them exactly in the same way with the same level of quality/management.

You will find more details about add-ons (**and a list of them**) in the [dedicated documentation page]({{addons}}).
