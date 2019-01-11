<a name="unreleased"></a>
## [Unreleased]

### Feat
- add filebeat component
- add openjdk as a non default layer
- clean some useless files in .plugin files
- introduce monitoring layer (loaded by default) and move telegraf inside
- telegraf update (1.7.4 => 1.9.1)
- update urllib3 (1.22 => 1.23)
- upgrade netCDF4 python from 1.4.0 to 1.4.2
- upgrade python3 from 3.5.3 to 3.5.6 and python2 from 2.7.9 to 2.7.15

### Fix
- rpm names was incorrect with release tags
- rpm names were incorrect with release tags

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

