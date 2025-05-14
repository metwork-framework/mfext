# release_2.2 CHANGELOG

## v2.2.14 (2025-05-13)

### New Features

- add proj patch from synopsis with skew mercator projection (backport #1965) (#1980)
- add PostGreSQL extension pg_uuidv7 (backport #1957) (#1979)
- bump Python 3.11 from 3.11.10 to 3.11.11 (#2003)
- bump certifi to 2024.7.4 (to fix CVE-2024-39689) (backport #1904) (#2268)
- bump zipp from 3.16.2 to 3.19.2 (fix CVE-2024-5569) (backport #1906) (#2269)
- bump Python 3.11 from 3.11.11 to 3.11.12 (#2281)
- bump certifi from 2025.1.31 to 2025.4.26 (backport #2300) (#2301)
- bump pg_partman from 4.5.1 to 5.2.4 (backport #2314) (#2315)

### Bug Fixes

- remove useless git alias (#2175)

## v2.2.13 (2024-11-04)

- No interesting change

## v2.2.12 (2024-09-14)

### New Features

- create salem sample data file to avoid further http requests (backport #1931) (#1932)
- upgrade Python 3.11 from 3.11.9 to 3.11.10  (#1948)

### Bug Fixes

- upgrade xattrfile to fix mfdata issue 486 (backport #1935) (#1937)

## v2.2.11 (2024-08-22)

### New Features

- add zstd support in PostGreSQL (backport #1914) (#1918)

## v2.2.10 (2024-05-31)

### New Features

- fix CVE-2020-11724 on openresty 1.15.8  (backport #1865) (#1868)
- bump aiohttp to 3.9.5 to fix CVE-2024-27306 (#1867)
- bump tqdm to 4.66.4 (fix CVE-2024-34062) (backport #1879) (#1880)
- bump Werkzeug from 3.0.1 to 3.0.3 (fix CVE-2024-34069) (backport #1882) (#1883)
- bump Jinja2 to 3.1.4 (fix CVE-2024-34064) (backport #1884) (#1886)
- add libssl.so.1.1 and libcrypto.so.1.1 in embedded system dependencies (#1889)

## v2.2.9 (2024-04-15)

### New Features

- upgrade Python from 3.11.7 to 3.11.9 (backport #1845) (#1850)
- upgrade pip from 23.3.2 to 24.0 (built-in version in Python 3.1.9) (backport #1849) (#1851)
- bump idna from 3.4 to 3.7 (to fix CVE-2024-3651) (#1860)

## v2.2.8 (2024-04-11)

### New Features

- do not remove module's HOME nor metwork service when uninstalling (backport #1842) (#1844)

### Bug Fixes

- remove pip conflicts warnings when using override (#1840)

## v2.2.7 (2024-04-05)

### New Features

- add panoply in layer python3_devtools
- bump black from 23.11.0 to 24.3.0 (security update) (backport #1836) (#1837)

### Bug Fixes

- fix mfbase.start in case NOINIT (#1825)

## v2.2.6 (2024-03-09)

### New Features

- add python package astral (#1820)

## v2.2.5 (2024-02-27)

### Bug Fixes

- set postgis extension as trusted (#1811)

## v2.2.4 (2024-02-01)

### New Features

- bump aiohttp from 3.9.1 to 3.9.3 (for security reasons) (#1802)

## v2.2.3 (2024-01-23)

### New Features

- upgrade gitignore-parser to 0.1.11 (with our fix for symlinks)  (#1795)
- add bandit, filprofiler, GitPython, py-spy, pyinstaller (layer python3_devtools) (#1794)
- bump Jinja2 from 3.1.2 to 3.1.3 (fix GHSA-h5c8-rqwp-cp95) (#1799)

## v2.2.2 (2024-01-16)

### New Features

- upgrade gdal from 3.8.1 to 3.8.3 (backport #1777) (#1778)
- remove module's system crontab when uninstalling (#1776)
- bump pytest to 7.4.4 and add typer and typing-inspect (missing) (#1779)
- upgrade pip to 23.3.2 and setuptools to 69.0.3 (#1781)

## v2.2.1 (2023-12-20)

### New Features

- bump gdal from 3.8.0 to 3.8.1 (backport #1747) (#1748)
- upgrade Python 3.11 from 3.11.6 to 3.11.7 (backport #1749) (#1750)
- upgrade psutil from 5.9.5 to 5.9.7 (#1757)
- upgrade postgis-geohash to 0.1.2 (fix for PostGreSQL 16) (backport #1759) (#1760)
- bump paramiko to 3.4.0 (security against Terrapin attack) (#1762)

### Bug Fixes

- downgrade gitignore-parser to 0.1.8 (backport #1755) (#1756)

## v2.2.0 (2023-11-30)

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
- add a warning when loading a second and different Metwork profile (#1556)
- add pytest-json-report, setuptools-git-versioning, mypy-extensions (#1559)
- migrate from Python 3.10.9 to 3.10.10 (#1561)
- save module status to json file (#1572) (#1573)
- upgrade pytest-html to 4.0.0 and remove py dependency (#1576)
- upgrade Werkzeug from 2.2.3 to 2.3.4 (#1577)
- upgrade from Python 3.10.10 to Python 3.11.3 (#1578)
- bump pymdown-extensions from 9.8 to 10.0 (security update) (#1581)
- bump requests from 2.28.1 to 2.31.0 (security update) (#1582)
- bump tornado from 6.2 to 6.3.2 (for security reason) (#1585)
- bump importlib-metadata from 4.11.4 to 4.13.0 (#1586)
- add python package geojson (#1587)
- add protobuf-c and add protobuf support in postgis (#1589)
- bump cryptography from 39.0.1 to 41.0.1 (for security reason) (#1598)
- mfadmin crontab : keep kibana web interface and ES config (#1600)
- update gitignore-parser to 0.1.4 (#1606)
- bump cryptography to 41.0.2 (security update) (#1608)
- upgrade psycopg, psycopg2, psycopg-c to last releases (#1627)
- update certifi to 2023.7.22 (security update) (#1631)
- bump tornado to 6.3.3 (security update) (#1632)
- security : cryptography 41.0.3, aiohttp 3.8.5, Pygments 2.15.1 (#1633)
- bump redis from 4.3.6 to 4.4.4 (security update) (#1640)
- upgrade de circus en 0.18.0 et suppression de tornado 4.5.2 dans la layer circus (#1646)
- bump Python to 3.11.5, pip to 23.2.1 and wheel to 0.41.2 (#1647)
- bump redis from 5.0.5 to 5.0.14 (#1648)
- bump hiredis to 1.2.0 and hiredis-py to 2.2.3 (#1649)
- upgrade setuptools from 65.5.1 to 68.1.2 (#1654)
- upgrade many python packages in layer python3_core (#1655)
- many upgrades of python packages in layer python3 (#1657)
- use original jonashaag/bjoern instead of our fork (#1664)
- use a fork of requests-unixsocket with urllib3 > 2 (#1665)
- bump cached-property to 1.5.2 and pyzmq to 25.1.1 (layer circus) (#1666)
- upgrade postgresql to 15.4 and pgbouncer to 1.20.1 (#1667)
- upgrade gdal from 3.5.3 to 3.7.1
- upgrade gdal from 3.5.3 to 3.7.1 (#1668)
- upgrade to gdal 3.7.2 (#1671)
- upgrade hdf4 to 4.2.16-2 and hdf5 to 1.14.2 + add fortran support in hdf5 (#1669)
- upgrade netcdf_c from 4.9.0 to 4.9.2 (#1672)
- bump cryptography to 41.0.4 (security update) (#1675)
- enable hdf5 plugin dir for netcdf_c (#1676)
- back to our circus fork with tornado 4.5.3 in layer circus (#1685)
- upgrade proj from 9.0.1 to 9.3.0 (#1686)
- downgrade wrapt to 1.14.1 (compatibility with tensorflow 1.14) (#1687)
- upgrade typing-extensions from 4.5.0 to 4.8.0 (#1688)
- move python_ldap from layer python3_devtools to layer python3 (#1689)
- add make as dependency (for plugins build) (#1691)
- bump urllib3 to 2.0.6 (security update) (#1695)
- upgrade geos to 3.12.0 and fix gdal build (#1697)
- upgrade libspatialite from 5.0.1 to 5.1.0 (#1698)
- upgrade postgis from 3.3.1 to 3.4.0 (#1699)
- upgrade psycopg2, psycopg and psycopg-c to last releases (#1702)
- upgrade shellcheck to 0.9.0 (#1703)
- build nginx with ssi module (#1705)
- upgrade wrk to 4.2.0 (#1707)
- upgrade all packages in python3_devtools to last release (#1709)
- bump python redis to 5.0.1 (#1712)
- bump urllib3 to 2.0.7 (security update) (#1713)
- upgrade gitignore-parser to 0.1.9 (#1714)
- upgrade pgbouncer from 1.20.1 to 1.21.0 (#1715)
- upgrade Werkzeug from 2.3.7 to 3.0.1 (#1720)
- upgrade gdal from 3.7.2 to 3.7.3 (#1721)
- add pydantic and bump-pydantic (#1722)
- upgrade postgresql from 15.4 to 16.1 (#1724)
- upgrade Python to 3.11.6, pip to 23.3.1, setuptools to 68.2.2 (#1726)
- bump pytest-html to 4.1.1 (#1727)
- bump hdf5 to 1.14.3 and pytest to 7.4.3 (#1729)
- bump aiohttp from 3.8.5 to 3.8.6 (security update) (#1730)
- upgrade nodejs from 16.15.1 to 20.9.0 (#1732)
- upgrade gdal from 3.7.3 to 3.8.0 (#1731)
- upgrade black to 23.11.0 (#1733)
- upgrade urllib3 from 2.0.7 to 2.1.0 (#1734)
- upgrade setuptools from 68.2.2 to 69.0.2 (#1736)
- add pipdeptree (#1737)
- bump aiohttp from 3.8.6 to 3.9.1 (for security reason) (backport #1742) (#1743)
- bump cryptography from 41.0.4 to 41.0.7 (security) (backport #1745) (#1746)

### Bug Fixes

- fix #956 (#1473)
- plugin make - hide commands being executed (#1485) (#1486)
- .releaseignore / make release : incorrect exclusion with lines beginning with ! (#1490)
- update mfplugin to fix a tmpdir plugins issue (mfbase #212)  (#1492)
- issue when metwork group exists but is missing in /etc/group (#1495)
- do not echo on /dev/stderr, which doesn't work after sudo (#1530)
- remove useless and dangerous call to mfxxx.init in mfxxx.start (#1563)
- update redis to 4.3.6 to fix vulnerability (#1567)
- prevent error messages when uninstalling rpms in some corny case (#1570)
- fix mfxxx.autorestart (bug introduced by #1573) (#1645)
- log level is not CRITICAL if status is ok after restart (#1650)
- downgrade urllib3 to 1.26.16 for compatibility with requests>=2.29 (#1659)
- fix missing double quote in python3_wrapper (#1704)
- fix or disable shellcheck info (#1706)
- upgrade mfplugin to fix issue on terminaltables (backport #1739) (#1741)


