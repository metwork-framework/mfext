# release_0.4 branch CHANGELOG



## v0.4.1 (2019-01-10)

### New Features


### Bug Fixes
- rpm names were incorrect with release tags





## v0.4.0 (2019-01-08)

### New Features
- first import
- add websocket support for openresty
- add websocket support for openresty
- add integration_tests layer and rpm mfext-integration-tests
- mapserver introduction
- we increase some system limits (nofile and nproc)
- upgrade python requests because of security alert
- load mapserver layer by default (if available)
- we can now use plugin_env function in a plugin directory
- add pytest package and update some other ones
- upgrade eccodes to 2.9.0
- add mapserverapi library
- add mapserverapi_python
- Add postgresql support in gdal
- now we can use pip inside a "plugin env"
- add mapserverapi_python
- patch certifi for using system certificates on centos
- use normal "npm" workflow inside a "plugin_env"
- add geos, lxml, pycurl, pyproj and sqlalchemy
- check that module crontab is not empy in mfxxx.status
- better default MODULE_RUNTIME_SUFFIX
- Add possibility to pip install package from https url.
- guess released versions with tags
- add basemap, cdsapi, graphviz, pandas and scikit-learn
- add lxml, pycurl, pyproj and sqlalchemy as in python3
- telegraf is now monitoring itself
- add pygraphviz in python[23]_scientific layers
- add graphviz in scientific layer
- add diskcache in python2 and python3 layers
- telegraf update (1.7.1 => 1.7.4)
- upgrade eccodes from 2.9.0 to 2.10.0 and
- add lib, local/lib to `PYTHONPATH` by default (layers, plugins...)
- Add Fiona in python2 and python3 scientific layers
- expose new function in layerapi2


### Bug Fixes
- fix branch guessing with drone ci
- fix drone build caching
- sqlite support for python2/python3
- fix error in template spec file for package mfserv and others
- depency issue with new mapserver subpackage
- mfxxx login problems in docker mode
- add mapserverapi_python
- block mfxxx.start/stop/status/init calls from a plugin_env
- fix build error
- mapserverapi upgrade (0.1.0 => 0.1.1)
- fix layer dependencies in new tests





