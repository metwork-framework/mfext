# Cheatsheet





## "load environment" commands

As a "not metwork" unix user (useless if you are logged as a "mfxxx" unix user as the "metwork environment" is already loaded):

| Command | Description |
| --- | --- |
| `source /opt/metwork-mfext/share/interactive_profile` | load the mfext metwork interactive environment |
| `source /opt/metwork-mfext/share/profile` | load the mfext metwork environment (same as above but without fancy stuff about banner, colors and prompt) |
| `/opt/metwork-mfext/bin/mfext_wrapper {YOUR_COMMAND}`| execute the given command in the mfext metwork environment without changing anything to the current environment |

> Note: if you don't have `/opt/metwork-mfext` symbolic link, use `/opt/metwork-mfext-{BRANCH}` instead.

## module commands


*(with the `mfext` environment loaded)*


| Command | Description |
| --- | --- |
| `layers` | list installed layers (loaded layers are prefixed by `(*)`), `layers --help` for more details |
| `layer_load {LAYER_NAME}` | load the given layer (which must be installed), example: `layer_load python2_devtools@mfext` |
| `layer_unload {LAYER_NAME}` | unload the given layer (which must be loaded), example: `layer_unload python2@mfext` |
| `components` | list installed software components (loaded components are prefixed by `(*)`), `components --help` for more details |
| `metwork_debug` | debug the current environment (layers, paths, versions...), useful for debugging or bug reporting |
| `outside {YOUR_COMMAND}`| execute the given command outside the metwork environment without changing anything to the current environment |




