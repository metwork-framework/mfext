# release_2.0 CHANGELOG

## [Unreleased]

### New Features

- upgrade redis from 5.0.5 to 7.4.6 (backport #2418) (#2486)

## v2.0.14 (2025-11-07)

### New Features

- upgrade openresty (nginx) from 1.15.8.4 to 1.27.1.2 (backport #2416) (#2478)

## v2.0.13 (2025-10-31)

### New Features

- upgrade Python 3.9 from 3.9.19 to 3.9.20 (#2004)
- bump Python 3.9 from 3.9.20 to 3.9.22 (#2283)
- bump Python 3.9 from 3.9.22 to 3.9.23 (#2359)
- modules' home directory is now outside Metwork rpms (#2432)
- save permissions and acl by admin shell and restore them at update (#2462)

## v2.0.12 (2024-09-14)

### New Features

- add libssl.so.1.1 and libcrypto.so.1.1 in embedded system dependencies (#1889)
- upgrade python 3.9 from 3.9.19 to 3.19.20 (#1946)

## v2.0.11 (2024-04-14)

### New Features

- upgrade Python 3.9 from 3.9.18 to 3.9.19 (#1859)

## v2.0.10 (2024-04-12)

### New Features

- do not remove module's HOME nor metwork service when uninstalling (backport #1842) (#1854)

## v2.0.9 (2023-12-13)

### New Features

- upgrade Python 3.9 from 3.9.7 to 3.9.18 (#1752)

## v2.0.8 (2023-10-02)

### New Features

- add make as dependency (for plugins build) (#1691)

### Bug Fixes

- log level is not CRITICAL if status is ok after restart (backport #1650) (#1651)

## v2.0.7 (2023-07-21)

- No interesting change

## v2.0.6 (2023-07-18)

### New Features

- add protobuf support in postgis (#1612)

## v2.0.5 (2023-06-30)

### New Features

- mfadmin crontab : keep kibana web interface and ES config (backport #1600) (#1602)

## v2.0.4 (2022-10-28)

### New Features

- upgrade postgresql from 14.2 to 14.5 (#1447)

## v2.0.3 (2022-09-28)

### New Features

- upgrade deploycron to fix string formatting on ValueError (backport #1394) (#1395)

### Bug Fixes

- #1408 temporary log files are not purged by the cron (backport #1411) (#1412)
- use MFDATA_DATA_IN_DIR for tmp files (backport #1413) (#1414)
- fix init error when [module]_LOG_MINIMAL_LEVEL is set to DEBUG (backport #1415) (#1416)

## v2.0.2 (2022-06-01)

### New Features

- upgrade proj from 6.2.1 to 6.3.2 and gdal from 3.0.2 to 3.0.4 (#1358)

## v2.0.1 (2022-05-19)

### Bug Fixes

- update envtpl to fix issues with jinja2 new major version (in so… (backport #1346) (#1349)

## v2.0.0 (2022-04-27)

### New Features

- add libtiff to add tiff support in several scientific packages … (#1232)
- add a new control file "override" to override metwork python pa… (#1242)
- build under centos8 (#1253)
- upgrade mkdocs from 1.1.2 to 1.2.3 to fix security vulnerability (#1263)
- upgrade pip to 21.2.3 and setuptools to 57.4.0 (#1264)
- add certifi patch for RockyLinux, upgrade certifi and distro (#1265)
- bump nltk from 3.6.5 to 3.6.7 to fix a security vulnerability (#1269)
- build hdf5 with szlib support and update system dependencies (#1274)
- upgrade log_proxy to change mode on logs (0644) (#1279)
- remove 19 components in core layer (replaced by system components) (#1287)
- remove tcltk layer (replaced by usage of system libraries) (#1304)
- remove libtiff, openjpeg2, jasper, pixman and cairo builds (replaced by usage of system libraries) (#1309)
- upgrade postgresql from 13.4 to 14.2 (#1310)
- add libgeotiff 1.7.1 and geotiff support in gdal (#1311)
- add ipython in python3_devtools@mfext
- bump paramiko to 2.10.3 to fix a security vulnerability (#1317)
- manage system dependencies to be able to install on fedora >= 34 (#1321)
- bump typing-extensions to 3.10.0.2 (for bokeh 2.4.2) (#1338)

### Bug Fixes

- fix acquisition module with python 3.9 (#1237)
- fix modules init/start/stop/status crashes on machines where sta… (#1254)
- fix profile loading when 'set -e' has been done (#1257)
- fix wrong directory cleaning by garbage_collector.sh (#1259)
- json_file=AUTO is now the same than json_file=null (#1272)
- rename gdal's internal g2clib symbols to avoid conflicts (#1320)


