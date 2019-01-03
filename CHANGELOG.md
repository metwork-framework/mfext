<a name=""></a>
# (unreleased)


### Bug Fixes

* add mapserverapi_python ([91f3524](https://github.com/metwork-framework/mfext/commit/91f3524))
* block mfxxx.start/stop/status/init calls from a plugin_env ([8e515d7](https://github.com/metwork-framework/mfext/commit/8e515d7)), closes [#112](https://github.com/metwork-framework/mfext/issues/112)
* depency issue with new mapserver subpackage ([80091ee](https://github.com/metwork-framework/mfext/commit/80091ee))
* fix branch guessing with drone ci ([f9bb425](https://github.com/metwork-framework/mfext/commit/f9bb425))
* fix build error ([b6d3faf](https://github.com/metwork-framework/mfext/commit/b6d3faf))
* fix drone build caching ([01860a3](https://github.com/metwork-framework/mfext/commit/01860a3))
* fix error in template spec file for package mfserv and others ([3671242](https://github.com/metwork-framework/mfext/commit/3671242))
* fix layer dependencies in new tests ([2ef9a42](https://github.com/metwork-framework/mfext/commit/2ef9a42))
* mapserverapi upgrade (0.1.0 => 0.1.1) ([297890e](https://github.com/metwork-framework/mfext/commit/297890e))
* mfxxx login problems in docker mode ([8349516](https://github.com/metwork-framework/mfext/commit/8349516)), closes [#84](https://github.com/metwork-framework/mfext/issues/84)
* sqlite support for python2/python3 ([89c3907](https://github.com/metwork-framework/mfext/commit/89c3907)), closes [#4](https://github.com/metwork-framework/mfext/issues/4)


### Features

* add basemap, cdsapi, graphviz, pandas and scikit-learn ([afc9cad](https://github.com/metwork-framework/mfext/commit/afc9cad))
* add diskcache in python2 and python3 layers ([4ff07b1](https://github.com/metwork-framework/mfext/commit/4ff07b1)), closes [#136](https://github.com/metwork-framework/mfext/issues/136)
* add filebeat component ([7f37ad9](https://github.com/metwork-framework/mfext/commit/7f37ad9))
* Add Fiona in python2 and python3 scientific layers ([92cdbbe](https://github.com/metwork-framework/mfext/commit/92cdbbe)), closes [#127](https://github.com/metwork-framework/mfext/issues/127)
* add geos, lxml, pycurl, pyproj and sqlalchemy ([7ad2840](https://github.com/metwork-framework/mfext/commit/7ad2840))
* add graphviz in scientific layer ([a44298b](https://github.com/metwork-framework/mfext/commit/a44298b))
* add integration_tests layer and rpm mfext-integration-tests ([e7683f6](https://github.com/metwork-framework/mfext/commit/e7683f6))
* add lib, local/lib to `PYTHONPATH` by default (layers, plugins...) ([ab425d7](https://github.com/metwork-framework/mfext/commit/ab425d7)), closes [metwork-framework/resources#24](https://github.com/metwork-framework/resources/issues/24)
* add lxml, pycurl, pyproj and sqlalchemy as in python3 ([fd5cd08](https://github.com/metwork-framework/mfext/commit/fd5cd08))
* add mapserverapi library ([1cc8895](https://github.com/metwork-framework/mfext/commit/1cc8895))
* add mapserverapi_python ([d173f3d](https://github.com/metwork-framework/mfext/commit/d173f3d))
* add mapserverapi_python ([e2a38a8](https://github.com/metwork-framework/mfext/commit/e2a38a8))
* add openjdk as a non default layer ([79e392a](https://github.com/metwork-framework/mfext/commit/79e392a))
* Add possibility to pip install package from https url. ([0cf2fdc](https://github.com/metwork-framework/mfext/commit/0cf2fdc))
* Add postgresql support in gdal ([fee0706](https://github.com/metwork-framework/mfext/commit/fee0706)), closes [#76](https://github.com/metwork-framework/mfext/issues/76)
* add pygraphviz in python[23]_scientific layers ([bc24c6d](https://github.com/metwork-framework/mfext/commit/bc24c6d))
* add pytest package and update some other ones ([c0132d1](https://github.com/metwork-framework/mfext/commit/c0132d1))
* add websocket support for openresty ([b3666b0](https://github.com/metwork-framework/mfext/commit/b3666b0))
* add websocket support for openresty ([8cfb72f](https://github.com/metwork-framework/mfext/commit/8cfb72f))
* better default MODULE_RUNTIME_SUFFIX ([612cf7b](https://github.com/metwork-framework/mfext/commit/612cf7b))
* check that module crontab is not empy in mfxxx.status ([190a0c8](https://github.com/metwork-framework/mfext/commit/190a0c8)), closes [#122](https://github.com/metwork-framework/mfext/issues/122)
* expose new function in layerapi2 ([85aec59](https://github.com/metwork-framework/mfext/commit/85aec59))
* first import ([00adaf7](https://github.com/metwork-framework/mfext/commit/00adaf7))
* guess released versions with tags ([0e588b9](https://github.com/metwork-framework/mfext/commit/0e588b9))
* introduce monitoring layer (loaded by default) and move telegraf ([20f8cbb](https://github.com/metwork-framework/mfext/commit/20f8cbb))
* load mapserver layer by default (if available) ([7e77a00](https://github.com/metwork-framework/mfext/commit/7e77a00))
* mapserver introduction ([c9e796b](https://github.com/metwork-framework/mfext/commit/c9e796b)), closes [#51](https://github.com/metwork-framework/mfext/issues/51)
* now we can use pip inside a "plugin env" ([d060a54](https://github.com/metwork-framework/mfext/commit/d060a54)), closes [#91](https://github.com/metwork-framework/mfext/issues/91)
* patch certifi for using system certificates on centos ([67d0cf1](https://github.com/metwork-framework/mfext/commit/67d0cf1))
* telegraf is now monitoring itself ([83d915b](https://github.com/metwork-framework/mfext/commit/83d915b))
* telegraf update (1.7.1 => 1.7.4) ([43703aa](https://github.com/metwork-framework/mfext/commit/43703aa))
* telegraf update (1.7.4 => 1.9.1) ([03ea481](https://github.com/metwork-framework/mfext/commit/03ea481))
* update urllib3 (1.22 => 1.23)  ([077012f](https://github.com/metwork-framework/mfext/commit/077012f))
* upgrade eccodes from 2.9.0 to 2.10.0 and ([dc72ff2](https://github.com/metwork-framework/mfext/commit/dc72ff2))
* upgrade eccodes to 2.9.0 ([86387bc](https://github.com/metwork-framework/mfext/commit/86387bc))
* upgrade netCDF4 python from 1.4.0 to 1.4.2 ([c547b57](https://github.com/metwork-framework/mfext/commit/c547b57)), closes [#162](https://github.com/metwork-framework/mfext/issues/162)
* upgrade python requests because of security alert ([f8590a9](https://github.com/metwork-framework/mfext/commit/f8590a9))
* use normal "npm" workflow inside a "plugin_env" ([aeda1e6](https://github.com/metwork-framework/mfext/commit/aeda1e6)), closes [#95](https://github.com/metwork-framework/mfext/issues/95)
* we can now use plugin_env function in a plugin directory ([9274024](https://github.com/metwork-framework/mfext/commit/9274024))
* we increase some system limits (nofile and nproc) ([c9632e3](https://github.com/metwork-framework/mfext/commit/c9632e3))



