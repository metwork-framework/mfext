# release_0.9 CHANGELOG



## v0.9.10 (2020-09-01)

### New Features
- build nginx with http_auth_request module (#884)


### Bug Fixes
- fix plugins.info in python2
- fix PKG_CONFIG_PATH order in some cases





## v0.9.9 (2020-05-07)

### New Features


### Bug Fixes
- fix systemctl startup with some circusctl versions





## v0.9.8 (2020-03-19)

### New Features


### Bug Fixes
- fix again a little warning





## v0.9.7 (2020-03-19)

### New Features
- cronwrapper update to fix uid collisions when mfserv is launched several times
- upgrade netcdf_c from 4.7.0 to 4.7.3






## v0.9.6 (2020-02-14)

### New Features
- cronwrap load custom profiles like bashrc/profile
- increase sysctl net.ipv4.tcp_max_syn_backlog


### Bug Fixes
- fix pip usage inside plugin_env (and change cwd for plugin_home)
- custom sysctl.conf was not applied during startup





## v0.9.5 (2020-01-24)

### New Features


### Bug Fixes
- remove some old aliases for vim in python2_devtools
- fix automatic restart
- fix nasty warning in mfdata plugin_env when admin is set





## v0.9.4 (2020-01-02)

- No interesting change


## v0.9.3 (2020-01-02)

### New Features
- update circus_autorestart_plugin


### Bug Fixes
- fix plugin_env behaviour in some corner cases





## v0.9.2 (2019-11-01)

### New Features
- add a banner about configured mfadmin module
- better interactive/GUI processes detection
- add a clear warning...
- systemd service improvments


### Bug Fixes
- fix metwork services start for systems where /sys is readonly
- mfserv_wrapper now loads custom metwork profiles





## v0.9.1 (2019-10-23)

- No interesting change


## v0.9.0 (2019-10-22)

### New Features
- upgrade netcdf and build with gcc/gfortran >= 4.5 for fortran compatibily with esmf on addon scientific
- introduce build extra dependencies
- new packaging + layerapi2 is now hosted in a dedicated repository
- embed libffi and use it instead of system library
- embed readline and use it instead of the system library
- move netcdf fortran from mfext to mfextaddon_scientific (so libgfortran is not needed any more as system dependency in mfext)
- embed libpng
- embed tcl/tk libraries and build python2/3 with them
- refactoring about #437, #432, #420
- add some system dependencies
- no more default passwords, prelimininary systemd support
- replace MODULE* environment variables names by MFMODULE* (MODULE_HOME becomes MFMODULE_HOME and so on)
- introduce components utility
- add black python component
- add hmac openresty component
- update layerapi2
- integrate mfcom in mfext as 3 mfext layers (misc, python2_misc and python3_misc)
- add NODE_PATH in metwork_debug output
- add empty option to plugin_wrapper
- infinite circus max_retry
- add wrk tool to devtools layer
- add wrk tool to devtools layer
- add some layerapi2 functions in mfutil


### Bug Fixes
- fix vi usage without devtools
- use vi in python2 mode when we are in python2
- fix issue #35 on addon scientific (build problem with python2 ESMF)
- fix complex issues with some extra layers in plugin_env
- don't write empty requirements{2,3}.txt file in case of errors
- fix dead link to plugins guide
- external_plugins/ directory for mfbase
- fix systemd service





