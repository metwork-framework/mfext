# release_1.1 CHANGELOG

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

### New Features

- drop sphinx libraries (replaced by mkdocs) (#899)
- load the python3_scientific_core layer by default (if installed) (#912)
- build postgresql with extension unaccent (for usage in mfbase) (#917)
- add pytest-html and missing dependencies on other packages (#960)
- add nose-html-reporting (#961)
- move jinja2 extensions packages to python3 layer (#996)
- upgrade pip from 18.1 to 20.2.4 (18.1 is too old to install som… (#1011)
- add xz (which allows to add lzma support in python, gdal, ...) (#1025)
- add cmake 3.19.1 (a recent release is necessary to build some p… (#1028)
- add vector tool (for preparing loki) (#1068)
- upgrade aiohttp from 3.6.3 to 3.7.4 to fix security vulnerability (#1075)
- upgrade python3 from 3.7.3 to 3.7.10 (#1081)
- upgrade setuptools from 42.0.2 to 54.1.2 with refactoring of la… (#1088)
- upgrade from python 3.7.10 to python 3.8.8 (#1091)
- upgrade Jinja2 from 2.10.1 to 2.11.3 to fix security vulnerability (#1093)
- upgrade cryptography from 2.9.2 to 3.2.1 to fix security vulner… (#1094)
- security updates (pyyaml 5.4.1 and cryptography 3.3.2) (#1102)
- remove nose-html-reporting which is not python3 compliant (#1104)
- bump pygments from 2.6.1 to 2.7.4 to fix security vulnerability (#1106)
- upgrade Python 3.8 to 3.8.9 (security updates) (#1107)

### Bug Fixes

- give up profile loading when a required layer is missing (with a… (#924)
- don't prevent mfserv/nginx to bind <1024 ports with setcap (#927)
- don't block root usage in CI configurations (#937)
- fix an issue with inject_file command in mfdata (#944)
- fix an issue in mfdata acquisition about default values in get_config_value() (#950)
- fix a cache issue with python custom functions with same name (#966)
- update opinionated_configparser (#975)
- fix error message in nginx_error with < 1024 port binding (#977)
- fix an interactive question in some cases during profile loading (#991)
- fix an issue with < 1024 port binding (#999)
- fix missing deps in centos8 (#1003)
- add missing postgresql support in gdal (#1010)
- fix template crontab (#1015)
- update acquisition to fix a mfdata issue (#1046)
- update aiohttp 3.6.2 => 3.6.3 (fix a bug with url encoding) (#1049)
- update acquisition pkg to fix typo with some failure policy conf (#1054)
- important fix about configuration overrides in /etc (#1056)
- avoid automatic cleaning of tmp/config_auto directory (#1058)
- fix nginx reload if binded to < 1024 port (#1061)
- fix some various issues with stop/start of modules (#1059)
- remove old useless configuration key (#1073)
- prevent a circus crash in some corner cases (#1076)


