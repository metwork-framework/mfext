# CHANGELOG


## [Unreleased]

### New Features
- load the python3_scientific_core layer by default (if installed) (#912)
- drop sphinx libraries (replaced by mkdocs) (#899)
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
- upgrade rpm from 4.9.1.3 to 4.15.1
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


### Bug Fixes
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





