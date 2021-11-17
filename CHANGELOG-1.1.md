# release_1.1 CHANGELOG

## v1.1.12 (2021-11-16)

### Bug Fixes

- fix regex which block the installation of httpx package (backport #1227) (#1228)

## v1.1.11 (2021-11-06)

### Bug Fixes

- fix pip options usage (backport #1220) (#1221)

## v1.1.10 (2021-10-29)

### Bug Fixes

- fix some special plugin builds (backport #1218) (#1219)

## v1.1.9 (2021-10-16)

### New Features

- update log_proxy to fix log_proxy_wrapper issue on CentOS 8 (backport #1207) (#1209)

## v1.1.8 (2021-10-07)

### Bug Fixes

- fix log_proxy crash in corner cases  (backport #1179) (#1182)
- if both layers python3_ia and python3_scientific are available, python3_scientific is loaded by default (backport #1203) (#1204)

## v1.1.7 (2021-06-24)

### Bug Fixes

- fix bad acquisition update (backport #1173) (#1175)

## v1.1.6 (2021-06-24)

### Bug Fixes

- update acquisition package to fix an issue in mfdata (backport #1170) (#1172)

## v1.1.5 (2021-06-22)

### Bug Fixes

- fix opinionated_configparser in a mfdata corner case (backport #1165) (#1167)

## v1.1.4 (2021-06-17)

- No interesting change

## v1.1.3 (2021-06-11)

### Bug Fixes

- fix MFEXT_VERSION env with released versions (backport #1134) (#1139)
- update vector component to fix some loki issues (backport #1140) (#1142)
- add a timeout in kill remaining processes (backport #1141) (#1144)
- update acquisition package to fix some issues in mfdata (backport #1150) (#1152)
- fix deadlock issue in rich lib by updating (backport #1156) (#1158)

## v1.1.2 (2021-05-18)

### New Features

- update py from 1.8.1 to 1.10.0 to fix security alert (CVE-2020-… (backport #1119) (#1126)
- bump urllib3 from 1.25.3 to 1.25.11 to fix a security vulnerabi… (backport #1121) (#1124)

### Bug Fixes

- mfutil update to fix some minor display issues with some term emulators (backport #1128) (#1130)
- fix vector usage in mfadmin module (#1131)

## v1.1.1 (2021-05-04)

- No interesting change

## v1.1.0 (2021-05-01)

- No interesting change


