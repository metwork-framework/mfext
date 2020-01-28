# CHANGELOG


## [Unreleased]

### New Features
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
- fix nasty warning in mfdata plugin_env when admin is set
- fix automatic restart
- remove some old aliases for vim in python2_devtools
- fix plugin_env behaviour in some corner cases
- correct translation error from French (wrong use of false friend "eventually")
- mfserv_wrapper now loads custom metwork profiles
- fix systemd service
- fix metwork services start for systems where /sys is readonly





