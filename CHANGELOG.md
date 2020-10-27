# release_1.0 CHANGELOG


## [Unreleased]

### New Features


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
- upgrade rpm from 4.9.1.3 to 4.15.1
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





