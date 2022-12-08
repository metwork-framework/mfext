# release_2.1 CHANGELOG

## [Unreleased]

### New Features

- update click to 8.1.2 and pytest to 7.1.1 (#1333)
- revert click upgrade, back to 7.0 (#1337)
- bump typing-extensions to 3.10.0.2 (for bokeh 2.4.2) (#1338)
- upgrade gdal from 3.0.2 to 3.3.3 (#1344)
- upgrade python 3.9 to 3.9.12; remove deprecated nose (#1345)
- remove all references to python2 (#1361)
- upgrade proj from 6.2.1 to 8.2.1 (#1364)
- upgrade pytz from 2019.1 to 2022.1 (required to upgrade pandas) (#1365)
- add jmespath and upgrade pdoc3 to 0.10.0 (#1366)
- allow plugins.uninstall to be called with plugin path or plugin name (#1369)
- add yq (jq wrapper for YAML/XML documents) (#1371)
- add libtree tool (ldd as a tree) (#1370)
- add hiredis and hiredis-py (#1373)
- upgrade nodejs from 10.16.3 to 16.15.1  (#1375)
- upgrade click from 7.0 to 8.1.3 (#1379)
- upgrade arrow from 0.14.2 to 0.17.0 (security update) (#1380)
- upgrade from python 3.9.12 to python 3.10.5 (#1383)
- do not build anymore libffi (using system library) (#1391)
- upgrade readline from 8.0 to 8.1.2 (#1393)
- upgrade deploycron to fix string formatting on ValueError (#1394)
- upgrade python from 3.10.5 to 3.10.7 (#1417)
- bump Mako from 1.1.2 to 1.2.3 (security update) (#1418)
- upgrade postgresql from 14.2 to 14.5 and pgbouncer to 1.17.0 (#1420)
- upgrade hdf5 from 1.10.5 to 1.10.9
- bump joblib from 0.17.0 to 1.2.0 (security update) (#1422)
- upgrade proj from 8.2.1 to 9.0.1
- upgrade geos from 3.8.0 to 3.10.3
- upgrade gdal from 3.3.3 to 3.5.2 (#1433)
- upgrade postgis from 3.1.4 to 3.3.1 (#1434)
- upgrade psycopg2 add add psycopg = psycopg3 (#1436)
- upgrade python packages in layer python3_core (#1444)
- upgrade PyScaffold, ConfigUpdater and others in python3 layer (#1449)
- upgrade to Jinja3 and upgrade many other python3 packages (#1453)
- upgrade many python3 packages in layer python3_devtools (#1457)
- bump cryptography from 37.0.4 to 38.0.3 (security update) (#1459)
- upgrade hdf5 to 1.12.2 and netcdf-c to 4.9.0 (#1461)
- upgrade from python 3.10.7 to python 3.10.8 (#1466)
- add pywget and sftp_py (#1467)

### Bug Fixes

- update envtpl to fix issues with jinja2 new major version (in so… (#1346)
- .configuration_cache deletion during make clean (#1367) (#1368)
- do not remove empty file "override" which is meaningful for Metwork
- do not remove empty file "override" which is meaningful for Metwork (#1377)
- #1408 temporary log files are not purged by the cron (#1411)
- use MFDATA_DATA_IN_DIR for tmp files (#1413)
- fix init error when [module]_LOG_MINIMAL_LEVEL is set to DEBUG (#1415)
- fix #956 (backport #1473) (#1474)


