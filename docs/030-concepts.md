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

You can inspect installed layers with the `layers` utility.

## Components

Most of theses **components** are not
maintained by the MetWork Framework team. For example, you will find inside a recent [Python](http://www.python.org) interpreter or some well known libraries like [CURL](https://curl.haxx.se/) or [GLIB2](https://developer.gnome.org/glib/).

You can inspect installed components with the `components` utility.

## Add-ons

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
