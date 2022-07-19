# CHANGELOG

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

### Bug Fixes

- update envtpl to fix issues with jinja2 new major version (in so… (#1346)
- .configuration_cache deletion during make clean (#1367) (#1368)
- do not remove empty file "override" which is meaningful for Metwork
- do not remove empty file "override" which is meaningful for Metwork (#1377)


