# release_1.0 CHANGELOG

## [Unreleased]

### Bug Fixes

- fix opinionated_configparser in a mfdata corner case (backport #1165) (#1166)

## v1.0.19 (2021-06-17)

- No interesting change

## v1.0.18 (2021-06-11)

### Bug Fixes

- fix MFEXT_VERSION env with released versions (backport #1134) (#1138)
- add a timeout in kill remaining processes (backport #1141) (#1143)
- update acquisition package to fix some issues in mfdata (backport #1150) (#1151)
- fix deadlock issue in rich lib by updating (backport #1156) (#1157)

## v1.0.17 (2021-05-13)

### New Features

- go back to Jinja2 2.10.1 (Magics 4.2.0 on mfextaddon_scientific does not build with 2.11.3 and python 3.7) (#1122)
- bump urllib3 from 1.25.3 to 1.25.11 to fix a security vulnerabi… (backport #1121) (#1123)

### Bug Fixes

- mfutil update to fix some minor display issues with some term emulators (backport #1128) (#1129)

## v1.0.16 (2021-04-29)

- No interesting change

## v1.0.15 (2021-04-28)

### New Features

- add xz (which allows to add lzma support in python, gdal, ...) (bp #1025) (#1095)
- upgrade Jinja2 from 2.10.1 to 2.11.3 to fix security vulnerability (#1093)

## v1.0.14 (2021-03-05)

### Bug Fixes

- remove old useless configuration key (bp #1073) (#1074)
- prevent a circus crash in some corner cases (bp #1076) (#1078)

## v1.0.13 (2021-02-11)

### Bug Fixes

- fix some various issues with stop/start of modules (bp #1059) (#1063)

## v1.0.12 (2021-01-29)

### Bug Fixes

- avoid automatic cleaning of tmp/config_auto directory (bp #1058) (#1060)
- fix nginx reload if binded to < 1024 port (bp #1061) (#1062)

## v1.0.11 (2021-01-28)

### Bug Fixes

- important fix about configuration overrides in /etc (bp #1056) (#1057)

## v1.0.10 (2021-01-25)

### Bug Fixes

- update acquisition pkg to fix typo with some failure policy conf (bp #1054) (#1055)

## v1.0.8 (2021-01-21)

### Bug Fixes

- update aiohttp 3.6.2 => 3.6.3 (fix a bug with url encoding) (bp #1049) (#1050)

## v1.0.9 (2021-01-21)

- No interesting change

## v1.0.7 (2021-01-06)

### Bug Fixes

- update acquisition to fix a mfdata issue (bp #1046) (#1047)

## v1.0.6 (2020-12-03)

### New Features

- move jinja2 extensions packages to python3 layer (bp #996) (#997)

### Bug Fixes

- fix an interactive question in some cases during profile loading (bp #991) (#992)
- fix an issue with < 1024 port binding (bp #999) (#1002)
- add missing postgresql support in gdal (bp #1010) (#1012)
- fix missing deps in centos8 (bp #1003) (#1004)
- fix template crontab (bp #1015) (#1016)

## v1.0.5 (2020-11-24)

### Bug Fixes

- update opinionated_configparser (bp #975) (#976)
- fix error message in nginx_error with < 1024 port binding (bp #977) (#979)

## v1.0.4 (2020-11-19)

### Bug Fixes

- fix an issue in mfdata acquisition about default values in get_config_value() (bp #950) (#951)
- fix a cache issue with python custom functions with same name (bp #966) (#967)

## v1.0.3 (2020-11-03)

### Bug Fixes

- give up profile loading when a required layer is missing (with a… (bp #924) (#925)
- fix an issue with inject_file command in mfdata (bp #944) (#945)
- don't block root usage in CI configurations (bp #937) (#942)

## v1.0.2 (2020-10-27)

### Bug Fixes

- don't prevent mfserv/nginx to bind <1024 ports with setcap (bp #927) (#929)

## v1.0.1 (2020-09-25)

### New Features

- load the python3_scientific_core layer by default (if installed) (bp #912) (#913)

## v1.0.0 (2020-09-24)

### New Features

- systemd service improvments
- add a banner about configured mfadmin module
- better interactive/GUI processes detection
- add a clear warning...
- add wrk2 (variant of wrk)
- remove layer misc@mfext (share files and shells are moved to adm)
- upgrade pcre from 8.36 to 8.43
- upgrade sqlite from 3.8.8.3 to 3.30.1
- upgrade gdal from 2.2.4 to 2.4.3 (for compatibility after upgrade of sqlite to recent release)
- upgrade gdal from 2.2.4 to 2.4.3 (for compatibility after upgrade of sqlite to recent release)
- add makefiles to install python modules with pip when an induced compilation with scls is necessary
- upgrade c-ares from 1.12.0 to 1.15.0
- upgrade libxslt from 1.1.28 to 1.1.34
- upgrade openjpeg from 2.1.2 to 2.3.1
- upgrade postgresql from 10.1 to 10.11
- upgrade hdf5 from 1.10.2 to 1.10.5
- upgrade proj from 5.2.0 to 6.2.1 with patch to accept use of deprecated proj_api.h
- upgrade proj from 5.2.0 to 6.2.1 with patch to accept use of deprecated proj_api.h
- upgrade postgresql from 10.11 to 12.1 and postgis from 2.4.6 to 3.0.0
- upgrade geos from 3.7.1 to 3.8.0
- upgrade gdal from 2.4.3 to 3.0.2
- add pixman 0.38.4 and upgrade cairo from 1.14.12 to 1.17.2
- add json2syslog2elasticsearch
- add log_proxy
- replace ack by ag (the_silver_searcher)
- update nodejs from 10.16.0 to 10.16.3
- update circus_autorestart_plugin
- upgrade libspatialite from 4.3.0a to 5.0.0-beta0
- reintroduce MFCOM_HOME for plugins migration
- add mkdocs components
- update python2_devtools/python3_devtools components
- update cronwrapper
- add pdoc3 python3 component
- update openjdk from 11.0.2 to 11.0.5, with download from AdoptOpenJDK
- new opinionated_configparser and corresponding changes
- set default mfsysmon admin/hostname config to localhost
- end of configparser_extended migration
- set TMPDIR automatically
- plugins checks
- cronwrap load custom profiles like bashrc/profile
- add coredump size limit in config
- if core_size = -1, ulimit -c is not set
- build all mfext with devtoolset-8 (gcc-8)
- remove python2/3_misc layers
- better interactive profile for mfext
- update telegraf component
- use LOGPROXY_LOG_DIRECTORY env variable for log paths
- introduce automatic cleaning of tmp directory
- add distro python3 component
- add metwork module version and os name/version
- remove upload system account by default
- increase sysctl net.ipv4.tcp_max_syn_backlog
- collect and forward metwork plugin versions
- python requests-toolbelt component replaced by requests-unixsocket
- publish metwork module status on mfadmin
- update log_proxy to get dot control files
- add possibility to exclude files when releasing a plugin and update mfutil
- move all python2 stuff out of mfext (moved in a dedicated mfext addon)
- do not build the layer if file .bypass_build_if_missing contains not available layers
- custom prompt for virtualenv
- cronwrapper update
- we can use *_CURRENT_PLUGIN_* variables in plugin crontabs
- mflog update
- upgrade netcdf_c from 4.7.0 to 4.7.3
- add fontconfig and freetype (moved from mfextaddon_scientific)
- update log_proxy to fix problem when a maximum file size if set by ulimit
- update mfutil to get explicit error messages in some cases when building plugin specfile
- add extension plpython3u to postgresql
- add python3 package 'pika'
- add a new feature in circus_hooks with special exit code 200
- remove all references to MFCOM or mfcom, including backward compatibily stuff
- add xattrfile from specific Metwork repo (was before included in mfdata)
- update log_proxy to version 0.1.0 (fix a potential deadlock in some corner cases)
- new plugin system
- add paramiko (python implementation of SSHv2) and dependencies
- add python3 devtools components (pytest-xdist, pytest-mock, freezegun, recommonmark) and update other components
- add module acquisition (previously in mfdata)
- add directory_observer
- add directory_observer
- add aiohttp-metwork-middlewares and dependencies
- update acquisition to last version
- add psycopg2 in new layer python3_scientific_core@mfext (for use by mfbase, mfserv, mfdata)
- add mkdoc exclude plugin
- manage git requirements without "-e"
- update documentation
- better prompt with virtualenv and better pip management
- build nginx with http_auth_request module (#884)
- drop sphinx libraries (replaced by mkdocs) (bp #899) (#911)

### Bug Fixes

- fix metwork services start for systems where /sys is readonly
- fix systemd service
- mfserv_wrapper now loads custom metwork profiles
- correct translation error from French (wrong use of false friend "eventually")
- fix plugin_env behaviour in some corner cases
- remove some old aliases for vim in python2_devtools
- fix automatic restart
- fix nasty warning in mfdata plugin_env when admin is set
- fix pip usage inside plugin_env (and change cwd for plugin_home)
- custom sysctl.conf was not applied during startup
- fix issue 745 (problem with blank lines while editing crontab)
- fix compatibility with old systemd versions
- mfxxx.status must return 1 when errors occur
- fix python2 plugins build
- fix PKG_CONFIG_PATH order in some corner cases
- fix mfdata issue 288


