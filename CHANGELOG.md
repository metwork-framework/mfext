# CHANGELOG

## [Unreleased]

### New Features

- bump aiohttp from 3.8.6 to 3.9.1 (for security reason) (#1742)
- bump cryptography from 41.0.4 to 41.0.7 (security) (#1745)
- bump gdal from 3.8.0 to 3.8.1 (#1747)
- upgrade Python 3.11 from 3.11.6 to 3.11.7 (#1749)
- upgrade psutil from 5.9.5 to 5.9.7 (#1757)
- upgrade postgis-geohash to 0.1.2 (fix for PostGreSQL 16) (#1759)
- bump paramiko to 3.4.0 (security against Terrapin attack) (#1762)
- remove module's system crontab when uninstalling (#1766)
- upgrade gdal from 3.8.1 to 3.8.3 (#1777)
- bump pytest to 7.4.4 and add typer and typing-inspect (missing) (#1779)
- upgrade pip to 23.3.2 and setuptools to 69.0.3 (#1781)
- build sqlite 3.45.0 (for django5 requiring sqlite >= 3.27) (#1786)
- add bandit, filprofiler, GitPython, py-spy, pyinstaller (layer python3_devtools) (#1794)
- upgrade gitignore-parser to 0.1.11 (with our fix for symlinks)  (#1795)
- bump Jinja2 from 3.1.2 to 3.1.3 (fix GHSA-h5c8-rqwp-cp95) (#1799)
- bump aiohttp from 3.9.1 to 3.9.3 (for security reasons) (#1802)
- bump cryptography from 41.0.7 to 42.0.2 (security update) (#1806)
- upgrade log_proxy to 0.7.1 (new functionality) (#1807)
- upgrade log_proxy to last release (0.7.3) (#1809)
- bump cryptography from 42.0.2 to 42.0.5 (security update) (#1813)
- add security patch for nginx  (#1815)
- add python package astral (#1820)

### Bug Fixes

- upgrade mfplugin to fix issue on terminaltables (#1739)
- downgrade gitignore-parser to 0.1.8 (#1755)
- set postgis extension as trusted (#1811)
- fix mfbase.start in case NOINIT
- fix mfbase.start in case NOINIT (#1825)
- useless module mffront in service usage (closes #1829) (#1830)


