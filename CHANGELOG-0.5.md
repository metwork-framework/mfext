# release_0.5 CHANGELOG


## [Unreleased]

### New Features


### Bug Fixes
- jinja2 update (security) 2.10 => 2.10.1





## v0.5.8 (2019-04-02)

### New Features
- use our cookiecutter fork to add some features
- upgrade glib2 from 2.40.2 to 2.56.4






## v0.5.7 (2019-03-16)

- No interesting change


## v0.5.6 (2019-03-15)

### New Features
- introduce mfext addons


### Bug Fixes
- fix some installation issues in some corner cases





## v0.5.5 (2019-02-09)

- No interesting change


## v0.5.4 (2019-02-08)

### New Features
- prevent single rpm installation and make sure the layer root rpm is the last uninstalled rpm when uninstalling the module
- remove "aliases" rpms (replaced by the use of Provides in spec file)


### Bug Fixes
- upgrade mapserverapi (0.1.1 => 0.1.2)
- mapserverapi update (0.1.2 => 0.1.3)





## v0.5.3 (2019-02-05)

### New Features
- new utility "outside" to execute commands outside the metwork env
- Upgrade postgis from 2.4.4 to 2.4.6
- Upgrade postgis from 2.4.4 to 2.4.6


### Bug Fixes
- rpm names with release tags
- force epoch=1 in centos7 openssl dependency
- obsoletes wrong named packages





## v0.5.2 (2019-01-31)

- No interesting change


## v0.5.1 (2019-01-29)

- No interesting change


## v0.5.0 (2019-01-29)

### New Features
- update urllib3 (1.22 => 1.23)
- add openjdk as a non default layer
- add filebeat component
- introduce monitoring layer (loaded by default) and move telegraf
- telegraf update (1.7.4 => 1.9.1)
- upgrade netCDF4 python from 1.4.0 to 1.4.2
- clean some useless files in .plugin files
- upgrade python3 from 3.5.3 to 3.5.6 and python2 from 2.7.9 to
- lua-resty-stats upgrade (0.0.2 => 0.0.3)
- ignore lines starting with # in .layerapi2_dependencies/conflicts
- Simplify _metwork.spec with self discovery of layer dependencies
- add some metapackages aliases to have a cleaner installation doc
- we remove the src directory from .plugin files
- add a python3_ia layer
- add a way to install binary python wheels
- user-defined configuration name
- execute integration tests directly from mfext module


### Bug Fixes
- rpm names was incorrect with release tags
- rpm names were incorrect with release tags
- do not include .git* files in the plugin RPM
- circus update to fix some stop_signal issues (on circus itself)
- no doc(s) directory in a plugin release


### Performance Enhancements
- kill immediatly some watchers during circus shutdown




