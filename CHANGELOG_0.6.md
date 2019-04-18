# release_0.6 branch CHANGELOG


## [Unreleased]

### New Features


### Bug Fixes
- backport of #279 to fix metwork-framework/mflog#8





## v0.6.0 (2019-03-27)

### New Features
- new utility "outside" to execute commands outside the metwork env
- introduce new mflog library
- Upgrade geos from 3.6.2 to 3.7.1 (with scl for C++11 on centos6)
- Upgrade postgis from 2.4.4 to 2.4.6
- prevent single rpm installation and make sure the layer root rpm is the last uninstalled rpm when uninstalling the module
- remove "aliases" rpms (replaced by the use of Provides in spec file)
- upgrade mflog to latest master
- upgrade mflog to latest master
- introduce mfext addons
- mflog update (again)
- remove python3_ia layer (we are building an dedicated addon for
- delete filebeat component
- add a first version of jsonlog2elasticsearch
- add sphinx-automodapi module
- mfutil_c introduction and some profile changes
- use our cookiecutter fork to add some features
- upgrade glib2 from 2.40.2 to 2.56.4
- mflog update to fix some issues about null files
- use python27 scl (python 2.7.13) if python version < 2.8 (python 2.7.5 in centos7)
- refuse mfxxx.stop/start if the config.ini is newer than the current env


### Bug Fixes
- rpm names with release tags
- force epoch=1 in centos7 openssl dependency
- upgrade mapserverapi (0.1.1 => 0.1.2)
- mapserverapi update (0.1.2 => 0.1.3)
- fix mfxxx.start/stop/status when used in some special dirs
- fix some installation issues in some corner cases
- upgrade problems at RPM levels
- fix some rpm upgrades





