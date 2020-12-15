# release_0.8 CHANGELOG





## [Unreleased]







### New Features


- build postgresql with extension unaccent (for usage in mfbase) (bp #917) (#918)
- build nginx with http_auth_request module (#884)
- upgrade netcdf_c from 4.7.0 to 4.7.3
- cronwrapper update to fix uid collisions when mfserv is launched several times
- increase sysctl net.ipv4.tcp_max_syn_backlog
- cronwrap load custom profiles like bashrc/profile
- update circus_autorestart_plugin
- systemd service improvments
- add a clear warning...
- better interactive/GUI processes detection
- add a banner about configured mfadmin module
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


- fix an issue with < 1024 port binding (bp #999) (#1001)
- fix error message in nginx_error with < 1024 port binding (bp #977) (#978)
- don't block root usage in CI configurations (bp #937) (#941)
- don't prevent mfserv/nginx to bind <1024 ports with setcap (bp #927) (#928)
- fix PKG_CONFIG_PATH order in some cases
- fix plugins.info in python2
- fix systemctl startup with some circusctl versions
- fix again a little warning
- custom sysctl.conf was not applied during startup
- fix pip usage inside plugin_env (and change cwd for plugin_home)
- fix nasty warning in mfdata plugin_env when admin is set
- fix automatic restart
- remove some old aliases for vim in python2_devtools
- fix plugin_env behaviour in some corner cases
- mfserv_wrapper now loads custom metwork profiles
- fix metwork services start for systems where /sys is readonly
- fix systemd service
- external_plugins/ directory for mfbase
- fix dead link to plugins guide
- don't write empty requirements{2,3}.txt file in case of errors
- fix complex issues with some extra layers in plugin_env
- fix issue #35 on addon scientific (build problem with python2 ESMF)
- use vi in python2 mode when we are in python2
- fix vi usage without devtools







## v0.8.5 (2019-10-19)







### Bug Fixes


- external_plugins/ directory for mfbase







## v0.8.4 (2019-10-15)



- No interesting change







## v0.8.3 (2019-09-24)







### New Features


- add hmac openresty component







## v0.8.2 (2019-09-21)







### New Features


- introduce components utility







### Bug Fixes


- use vi in python2 mode when we are in python2







## v0.8.1 (2019-08-22)







### Bug Fixes


- fix vi usage without devtools







## v0.8.0 (2019-08-19)







### New Features


- update mfutil_c and introduce mfutil_lua
- mflog update to support non standard logging levels
- add revert_ldd.sh and external_dependencies.sh utilities
- nodejs/npm update (nodejs 8.11.2 => 10.16.0, npm/6.1.0 => npm/6.9.0)
- telegraf update (1.10.2 => 1.11.2)
- upgrade redis from 3 to 5
- give up modules start if precondition failed
- upgrade python3 from 3.5.6 to 3.7.3, python2 from 2.7.15 to 2.7.16 and all python requirements with use of libressl instead of openssl
- update cookiecutter_hooks (reduce multi blank lines to a single one and conform python code to pep8)
- use envtpl new option --reduce-multi-blank-lines
- upgrade envtpl (both in python requirements and under portable_envtpl devtool)
- preserve some extra env var in mfxxx_wrapper







### Bug Fixes


- plugin_env issue with python2 plugins
- disable SSE4.2 optimizations to avoid nginx crashing on old servers
- add pycodestyle (missing dependency for autopep8)
- add pycodestyle (missing dependency for autopep8)
- fix vim/vimdiff wrappers usage with git
- fix vimdiff wrapper
- close mflog issue11






