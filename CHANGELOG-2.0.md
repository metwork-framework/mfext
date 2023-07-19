# release_2.0 CHANGELOG

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


