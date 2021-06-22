# CHANGELOG

## [Unreleased]

### New Features

- bump urllib3 from 1.25.3 to 1.25.11 to fix a security vulnerabi… (#1121)
- update py from 1.8.1 to 1.10.0 to fix security alert (CVE-2020-… (#1119)
- add jq and its dependency onig (#1145)
- add PostGreSQL extension postgresql_airtide (#1148)
- bump urllib3 from 1.25.11 to 1.26.5 to fix security alert GHSA-… (#1153)
- move libpng, freetype and fontconfig to layer core and build tk… (#1168)

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


