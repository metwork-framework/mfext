# release_0.9 CHANGELOG


## [Unreleased]

### New Features
- add some layerapi2 functions in mfutil
- add wrk tool to devtools layer
- add wrk tool to devtools layer
- infinite circus max_retry
- add empty option to plugin_wrapper
- add NODE_PATH in metwork_debug output
- integrate mfcom in mfext as 3 mfext layers (misc, python2_misc and python3_misc)
- update layerapi2
- add hmac openresty component
- add black python component
- introduce components utility
- replace MODULE* environment variables names by MFMODULE* (MODULE_HOME becomes MFMODULE_HOME and so on)
- no more default passwords, prelimininary systemd support
- add some system dependencies
- refactoring about #437, #432, #420
- embed tcl/tk libraries and build python2/3 with them
- embed libpng
- move netcdf fortran from mfext to mfextaddon_scientific (so libgfortran is not needed any more as system dependency in mfext)
- embed readline and use it instead of the system library
- embed libffi and use it instead of system library
- new packaging + layerapi2 is now hosted in a dedicated repository
- introduce build extra dependencies
- upgrade netcdf and build with gcc/gfortran >= 4.5 for fortran compatibily with esmf on addon scientific


### Bug Fixes
- fix systemd service
- external_plugins/ directory for mfbase
- fix dead link to plugins guide
- don't write empty requirements{2,3}.txt file in case of errors
- fix complex issues with some extra layers in plugin_env
- fix issue #35 on addon scientific (build problem with python2 ESMF)
- use vi in python2 mode when we are in python2
- fix vi usage without devtools





