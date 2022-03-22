# CHANGELOG

## [Unreleased]

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

### Bug Fixes

- fix acquisition module with python 3.9 (#1237)
- fix modules init/start/stop/status crashes on machines where sta… (#1254)
- fix profile loading when 'set -e' has been done (#1257)
- fix wrong directory cleaning by garbage_collector.sh (#1259)
- json_file=AUTO is now the same than json_file=null (#1272)


