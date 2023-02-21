# CHANGELOG

## [Unreleased]

### New Features

- add release in mfplugin configuration (#1482)
- upgrade certifi to 2022.12.7 (security upgrade) (#1483)
- upgrade liquidprompt to 2.1.2 (#1510)
- remove python package future, useless since python2 is dead (#1511)
- add python-ldap and dependencies in layer python3_devtools (#1515)
- keep permissions on /home/mfxxx and .ssh directory when upgrading (#1525)
- upgrade from python 3.10.8 to 3.10.9 (#1540)
- upgrade cryptography from 38.0.3 to 39.0.1 (security upgrade) (#1546)
- bump ipython from 8.6.0 to 8.10.0 (security update) (#1548)
- upgrade Werkzeug to 2.2.3 (security upgrade) (#1551)

### Bug Fixes

- fix #956 (#1473)
- plugin make - hide commands being executed (#1485) (#1486)
- .releaseignore / make release : incorrect exclusion with lines beginning with ! (#1490)
- update mfplugin to fix a tmpdir plugins issue (mfbase #212)  (#1492)
- issue when metwork group exists but is missing in /etc/group (#1495)
- do not echo on /dev/stderr, which doesn't work after sudo (#1530)


