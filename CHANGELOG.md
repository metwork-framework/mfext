<a name="unreleased"></a>
## [Unreleased]

### Feat
- Upgrade geos from 3.6.2 to 3.7.1 (with scl for C++11 on centos6)
- Upgrade postgis from 2.4.4 to 2.4.6
- add a first version of jsonlog2elasticsearch
- add sphinx-automodapi module
- delete filebeat component
- introduce mfext addons
- introduce new mflog library
- mflog update (again)
- mfutil_c introduction and some profile changes
- new utility "outside" to execute commands outside the metwork env
- prevent single rpm installation and make sure the layer root rpm is the last uninstalled rpm when uninstalling the module
- remove "aliases" rpms (replaced by the use of Provides in spec file)
- remove python3_ia layer (we are building an dedicated addon for that)
- upgrade mflog to latest master
- use our cookiecutter fork to add some features

### Fix
- fix mfxxx.start/stop/status when used in some special dirs
- fix some installation issues in some corner cases
- force epoch=1 in centos7 openssl dependency
- mapserverapi update (0.1.2 => 0.1.3)
- rpm names with release tags
- upgrade mapserverapi (0.1.1 => 0.1.2)

<a name="v0.5.7"></a>
## [v0.5.7] - 2019-03-16

<a name="v0.5.6"></a>
## [v0.5.6] - 2019-03-15
### Feat
- introduce mfext addons
- prevent single rpm installation and make sure the layer root rpm is the last uninstalled rpm when uninstalling the module
- remove "aliases" rpms (replaced by the use of Provides in spec file)

### Fix
- fix some installation issues in some corner cases

<a name="v0.5.5"></a>
## [v0.5.5] - 2019-02-09

<a name="v0.5.4"></a>
## [v0.5.4] - 2019-02-08
### Fix
- mapserverapi update (0.1.2 => 0.1.3)
- upgrade mapserverapi (0.1.1 => 0.1.2)

<a name="v0.5.3"></a>
## [v0.5.3] - 2019-02-04
### Feat
- Upgrade postgis from 2.4.4 to 2.4.6
- new utility "outside" to execute commands outside the metwork env

### Fix
- force epoch=1 in centos7 openssl dependency
- obsoletes wrong named packages
- rpm names with release tags

<a name="v0.5.2"></a>
## [v0.5.2] - 2019-01-31

<a name="v0.5.1"></a>
## [v0.5.1] - 2019-01-29

<a name="v0.5.0"></a>
## [v0.5.0] - 2019-01-29
### Feat
- Simplify _metwork.spec with self discovery of layer dependencies and management of metapackage names (keep only scientific and devtools and add minimal and full)  Associated with other changes in all modules, this reduces the number  of layers installed by default when installing a module (only necessary  mfext layers are installed)
- add a python3_ia layer
- add a way to install binary python wheels
- add filebeat component
- add openjdk as a non default layer
- add some metapackages aliases to have a cleaner installation doc
- clean some useless files in .plugin files
- execute integration tests directly from mfext module and launch them on a pull request on the module
- ignore lines starting with # in .layerapi2_dependencies/conflicts files
- introduce monitoring layer (loaded by default) and move telegraf inside
- lua-resty-stats upgrade (0.0.2 => 0.0.3)
- telegraf update (1.7.4 => 1.9.1)
- update urllib3 (1.22 => 1.23)
- upgrade netCDF4 python from 1.4.0 to 1.4.2
- upgrade python3 from 3.5.3 to 3.5.6 and python2 from 2.7.9 to 2.7.15
- user-defined configuration name
- we remove the src directory from .plugin files

### Fix
- circus update to fix some stop_signal issues (on circus itself)
- do not include .git* files in the plugin RPM
- no doc(s) directory in a plugin release
- rpm names was incorrect with release tags
- rpm names were incorrect with release tags

### Perf
- kill immediatly some watchers during circus shutdown

<a name="v0.4.1"></a>
## [v0.4.1] - 2019-01-10
### Fix
- rpm names were incorrect with release tags

<a name="v0.4.0"></a>
## [v0.4.0] - 2019-01-08
### Docs
- add badges to README

### Feat
- Add Fiona in python2 and python3 scientific layers (built separately with scl if gcc version < 4.8)
- Add possibility to pip install package from https url. The requirement must be of the following form : https://url#egg=package\n Example for basemap which has no link in pypi : https://downloads.sourceforge.net/project/matplotlib/matplotlib-toolkits/basemap-1.0.7/basemap-1.0.7.tar.gz#egg=basemap\n Add https://downloads.sourceforge.net as trusted-host for pip
- Add postgresql support in gdal
- add basemap, cdsapi, graphviz, pandas and scikit-learn (python2 and python3). For the time being, we don't add Fiona (doesn't compile on CentOS6 with gcc 4.4.7) nor pygraphviz (needs rpm graphviz we will build on scientific layer)
- add diskcache in python2 and python3 layers
- add geos, lxml, pycurl, pyproj and sqlalchemy
- add graphviz in scientific layer
- add integration_tests layer and rpm mfext-integration-tests
- add lib, local/lib to `PYTHONPATH` by default (layers, plugins...)
- add lxml, pycurl, pyproj and sqlalchemy as in python3 (not geos because it's python3 only)
- add mapserverapi library
- add mapserverapi_python
- add pygraphviz in python[23]_scientific layers (not in 0500_extra_packages because of some compilation issues)
- add pytest package and update some other ones
- add websocket support for openresty
- better default MODULE_RUNTIME_SUFFIX
- check that module crontab is not empy in mfxxx.status
- expose new function in layerapi2
- guess released versions with tags
- load mapserver layer by default (if available)
- mapserver introduction
- now we can use pip inside a "plugin env"
- patch certifi for using system certificates on centos
- telegraf is now monitoring itself
- telegraf update (1.7.1 => 1.7.4)
- upgrade eccodes from 2.9.0 to 2.10.0 and add python3 support in python3_scientific
- upgrade eccodes to 2.9.0
- upgrade python requests because of security alert
- use normal "npm" workflow inside a "plugin_env"
- we can now use plugin_env function in a plugin directory
- we increase some system limits (nofile and nproc)

### Fix
- add mapserverapi_python (added in requirements-to-freeze.txt but not in requirements3.txt)
- block mfxxx.start/stop/status/init calls from a plugin_env
- depency issue with new mapserver subpackage
- fix branch guessing with drone ci
- fix build error
- fix drone build caching
- fix error in template spec file for package mfserv and others
- fix layer dependencies in new tests
- mapserverapi upgrade (0.1.0 => 0.1.1)
- mfxxx login problems in docker mode
- sqlite support for python2/python3

