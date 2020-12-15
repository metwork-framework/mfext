# release_0.7 CHANGELOG





## [Unreleased]







### New Features


- move jinja2 extensions packages to python3 layer (bp #996) (#997)
- load the python3_scientific_core layer by default (if installed) (bp #912) (#913)
- drop sphinx libraries (replaced by mkdocs) (bp #899) (#911)
- build nginx with http_auth_request module (#884)
- better prompt with virtualenv and better pip management
- update documentation
- manage git requirements without "-e"
- add mkdoc exclude plugin
- add psycopg2 in new layer python3_scientific_core@mfext (for use by mfbase, mfserv, mfdata)
- update acquisition to last version
- add aiohttp-metwork-middlewares and dependencies
- add directory_observer
- add directory_observer
- add module acquisition (previously in mfdata)
- add python3 devtools components (pytest-xdist, pytest-mock, freezegun, recommonmark) and update other components
- add paramiko (python implementation of SSHv2) and dependencies
- new plugin system
- update log_proxy to version 0.1.0 (fix a potential deadlock in some corner cases)
- add xattrfile from specific Metwork repo (was before included in mfdata)
- remove all references to MFCOM or mfcom, including backward compatibily stuff
- add a new feature in circus_hooks with special exit code 200
- add python3 package 'pika'
- add extension plpython3u to postgresql
- update mfutil to get explicit error messages in some cases when building plugin specfile
- update log_proxy to fix problem when a maximum file size if set by ulimit
- add fontconfig and freetype (moved from mfextaddon_scientific)
- upgrade netcdf_c from 4.7.0 to 4.7.3
- mflog update
- we can use *_CURRENT_PLUGIN_* variables in plugin crontabs
- cronwrapper update
- custom prompt for virtualenv
- do not build the layer if file .bypass_build_if_missing contains not available layers
- move all python2 stuff out of mfext (moved in a dedicated mfext addon)
- add possibility to exclude files when releasing a plugin and update mfutil
- update log_proxy to get dot control files
- publish metwork module status on mfadmin
- python requests-toolbelt component replaced by requests-unixsocket
- collect and forward metwork plugin versions
- increase sysctl net.ipv4.tcp_max_syn_backlog
- remove upload system account by default
- add metwork module version and os name/version
- add distro python3 component
- introduce automatic cleaning of tmp directory
- use LOGPROXY_LOG_DIRECTORY env variable for log paths
- update telegraf component
- better interactive profile for mfext
- remove python2/3_misc layers
- build all mfext with devtoolset-8 (gcc-8)
- if core_size = -1, ulimit -c is not set
- add coredump size limit in config
- cronwrap load custom profiles like bashrc/profile
- plugins checks
- set TMPDIR automatically
- end of configparser_extended migration
- set default mfsysmon admin/hostname config to localhost
- new opinionated_configparser and corresponding changes
- update openjdk from 11.0.2 to 11.0.5, with download from AdoptOpenJDK
- add pdoc3 python3 component
- update cronwrapper
- update python2_devtools/python3_devtools components
- add mkdocs components
- reintroduce MFCOM_HOME for plugins migration
- upgrade libspatialite from 4.3.0a to 5.0.0-beta0
- update circus_autorestart_plugin
- update nodejs from 10.16.0 to 10.16.3
- replace ack by ag (the_silver_searcher)
- add log_proxy
- add json2syslog2elasticsearch
- add pixman 0.38.4 and upgrade cairo from 1.14.12 to 1.17.2
- upgrade gdal from 2.4.3 to 3.0.2
- upgrade geos from 3.7.1 to 3.8.0
- upgrade postgresql from 10.11 to 12.1 and postgis from 2.4.6 to 3.0.0
- upgrade proj from 5.2.0 to 6.2.1 with patch to accept use of deprecated proj_api.h
- upgrade proj from 5.2.0 to 6.2.1 with patch to accept use of deprecated proj_api.h
- upgrade hdf5 from 1.10.2 to 1.10.5
- upgrade postgresql from 10.1 to 10.11
- upgrade openjpeg from 2.1.2 to 2.3.1
- upgrade libxslt from 1.1.28 to 1.1.34
- upgrade c-ares from 1.12.0 to 1.15.0
- add makefiles to install python modules with pip when an induced compilation with scls is necessary
- upgrade gdal from 2.2.4 to 2.4.3 (for compatibility after upgrade of sqlite to recent release)
- upgrade gdal from 2.2.4 to 2.4.3 (for compatibility after upgrade of sqlite to recent release)
- upgrade sqlite from 3.8.8.3 to 3.30.1
- upgrade pcre from 8.36 to 8.43
- remove layer misc@mfext (share files and shells are moved to adm)
- add wrk2 (variant of wrk)
- add a clear warning...
- better interactive/GUI processes detection
- add a banner about configured mfadmin module
- systemd service improvments
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


- fix template crontab (bp #1015) (#1016)
- fix missing deps in centos8 (bp #1003) (#1004)
- add missing postgresql support in gdal (bp #1010) (#1012)
- fix an issue with < 1024 port binding (bp #999) (#1002)
- fix an interactive question in some cases during profile loading (bp #991) (#992)
- fix error message in nginx_error with < 1024 port binding (bp #977) (#979)
- update opinionated_configparser (bp #975) (#976)
- fix a cache issue with python custom functions with same name (bp #966) (#967)
- fix an issue in mfdata acquisition about default values in get_config_value() (bp #950) (#951)
- don't block root usage in CI configurations (bp #937) (#942)
- fix an issue with inject_file command in mfdata (bp #944) (#945)
- give up profile loading when a required layer is missing (with a… (bp #924) (#925)
- don't prevent mfserv/nginx to bind <1024 ports with setcap (bp #927) (#929)
- fix mfdata issue 288
- fix PKG_CONFIG_PATH order in some corner cases
- fix python2 plugins build
- mfxxx.status must return 1 when errors occur
- fix compatibility with old systemd versions
- fix issue 745 (problem with blank lines while editing crontab)
- custom sysctl.conf was not applied during startup
- fix pip usage inside plugin_env (and change cwd for plugin_home)
- fix nasty warning in mfdata plugin_env when admin is set
- fix automatic restart
- remove some old aliases for vim in python2_devtools
- fix plugin_env behaviour in some corner cases
- correct translation error from French (wrong use of false friend "eventually")
- mfserv_wrapper now loads custom metwork profiles
- fix systemd service
- fix metwork services start for systems where /sys is readonly
- external_plugins/ directory for mfbase
- fix dead link to plugins guide
- don't write empty requirements{2,3}.txt file in case of errors
- fix complex issues with some extra layers in plugin_env
- fix issue #35 on addon scientific (build problem with python2 ESMF)
- use vi in python2 mode when we are in python2
- fix vi usage without devtools
- plugin_env issue with python2 plugins
- disable SSE4.2 optimizations to avoid nginx crashing on old servers
- add pycodestyle (missing dependency for autopep8)
- add pycodestyle (missing dependency for autopep8)
- fix vim/vimdiff wrappers usage with git
- fix vimdiff wrapper
- close mflog issue11







## v0.7.2 (2019-08-06)







### New Features


- mflog update to support non standard logging levels







### Bug Fixes


- plugin_env issue with python2 plugins







## v0.7.1 (2019-06-27)







### New Features


- give up modules start if precondition failed







### Bug Fixes


- disable SSE4.2 optimizations to avoid nginx crashing on old servers







## v0.7.0 (2019-05-29)







### New Features


- preserve some extra env var in mfxxx_wrapper
- add libev component
- restore env after exiting plugin_env
- add terminaltables component
- add some sysctl tunings
- add werkzeug component (python wsgi toolbox)
- add sqlite3 and libspatialite supports to gdal
- keep request_id field in logs
- openresty update (1.11.2.2 => 1.13.6.2)
- update openjdk 11.0.1 => 11.0.2 and add mirror
- add cookiecutter_hooks project
- add search_paths feature to cookiecutter
- urllib3 update (1.23 => 1.24.2) because of upstream security issue
- allow to build mfext behing a corporate http proxy
- add graphviz in devtools layer (for documentation)
- update mflog
- remove prerequirements files
- update mflog and use new automatic context function
- telegraf update
- mflog update
- introduce mflog2mfadmin feature
- split old scientific layer between scientific_core layer
- try to keep a backup of user files during uninstall







### Bug Fixes


- fix vimdiff wrapper
- fix vim/vimdiff wrappers usage with git
- close mflog issue11
- better vim wrappers (specially in plugin_env)
- obsoletes removed python layer
- fix bug CHANGELOGS not generated when CHANGELOGS.md doesn't exist (for the first time)
- add a patch for openresty about nginx upstreams
- use python3 to build glib2 python tools and remove references to python scl in these tools
- update internal circus version to fix a bug with async_kill feature
- fix building issues with proxy
- jinja2 update (security) 2.10 => 2.10.1
- don't launch mflog2mfadmin is admin hostname is null
- more reliable checks about some circus watchers
- upgrade mflog to fix metwork-framework/mflog#8
- only the layers corresponding to the current addon should be in the
- fix the making of circus.ini from template on mfadmin (mfadmin.start was not working anymore)






