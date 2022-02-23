# release_1.2 CHANGELOG

## [Unreleased]

### New Features

- upgrade log_proxy to change mode on logs (0644) (backport #1279) (#1280)

## v1.2.3 (2022-02-02)

### New Features

- add certifi patch for RockyLinux, upgrade certifi and distro (#1266)
- bump nltk from 3.6.5 to 3.6.7 to fix a security vulnerability (backport #1269) (#1270)

### Bug Fixes

- fix wrong directory cleaning by garbage_collector.sh (backport #1259) (#1260)
- json_file=AUTO is now the same than json_file=null (backport #1272) (#1273)

## v1.2.2 (2022-01-11)

### New Features

- add a new control file "override" to override metwork python pa… (backport #1242) (#1244)

### Bug Fixes

- fix modules init/start/stop/status crashes on machines where sta… (backport #1254) (#1255)
- fix profile loading when 'set -e' has been done (backport #1257) (#1258)

## v1.2.1 (2021-12-11)

### Bug Fixes

- fix acquisition module with python 3.9 (backport #1237) (#1238)

## v1.2.0 (2021-11-24)

### New Features

- bump urllib3 from 1.25.3 to 1.25.11 to fix a security vulnerabi… (#1121)
- update py from 1.8.1 to 1.10.0 to fix security alert (CVE-2020-… (#1119)
- add jq and its dependency onig (#1145)
- add PostGreSQL extension postgresql_airtide (#1148)
- bump urllib3 from 1.25.11 to 1.26.5 to fix security alert GHSA-… (#1153)
- move libpng, freetype and fontconfig to layer core and build tk… (#1168)
- use a python3 wrapper for usages of python3 by glib  (#1177)
- add postgis-geohash (#1180)
- add pgbouncer and its dependency libevent (#1183)
- add extension pg_partman to PostgreSQL (#1185)
- add hdf4 + hdf4 support in netcdf and gdal (#1187)
- add pytest-asyncio (#1190)
- upgrade postgresql from 12.1 to 13.4 and postgis from 3.0.0 to 3.1.4 (#1197)
- switch from python 3.8 to python 3.9 (#1202)
- if both layers python3_ia and python3_scientific are available, python3_scientific is loaded by default
- upgrade nltk from 3.5 to 3.6.5 to fix a security vulnerability (#1205)
- update log_proxy to fix log_proxy_wrapper issue on CentOS 8 (#1207)
- increase vm.max_map_count for elasticsearch needs (#1214)
- add libtiff to add tiff support in several scientific packages … (backport #1232) (#1233)

### Bug Fixes

- mfutil update to fix some minor display issues with some term emulators (#1128)
- fix vector usage in mfadmin module (#1131)
- fix MFEXT_VERSION env with released versions
- update vector component to fix some loki issues (#1140)
- add a timeout in kill remaining processes (#1141)
- delete .configuration_cache during make clean (#1147)
- update acquisition package to fix some issues in mfdata (#1150)
- fix deadlock issue in rich lib by updating (#1156)
- fix opinionated_configparser in a mfdata corner case (#1165)
- update acquisition package to fix an issue in mfdata (#1170)
- fix bad acquisition update (#1173)
- fix log_proxy crash in corner cases  (#1179)
- do not load python3_ia by default (favor to python3_scientific)
- minor typo in code (#1212)
- fix some special plugin builds (#1218)
- fix pip options usage (#1220)
- fix regex which block the installation of httpx package (#1227)


