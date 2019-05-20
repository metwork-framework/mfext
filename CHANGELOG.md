# CHANGELOG


## [Unreleased]

### New Features
- add libev component
- restore env after exiting plugin_env
- add terminaltables component
- add some sysctl tunings
- add werkzeug component (python wsgi toolbox)
- add sqlite3 and libspatialite supports to gdal
- keep request_id field in logs
- openresty update (1.11.2.2 => 1.13.6.2)
- update openjdk 11.0.1 => 11.0.2 and add mirror
- add cookiecutter_hooks project
- add search_paths feature to cookiecutter
- urllib3 update (1.23 => 1.24.2) because of upstream security issue
- allow to build mfext behing a corporate http proxy
- add graphviz in devtools layer (for documentation)
- update mflog
- remove prerequirements files
- update mflog and use new automatic context function
- telegraf update
- mflog update
- introduce mflog2mfadmin feature
- split old scientific layer between scientific_core layer
- try to keep a backup of user files during uninstall


### Bug Fixes
- obsoletes removed python layer
- fix bug CHANGELOGS not generated when CHANGELOGS.md doesn't exist (for the first time)
- add a patch for openresty about nginx upstreams
- use python3 to build glib2 python tools and remove references to python scl in these tools
- update internal circus version to fix a bug with async_kill feature
- fix building issues with proxy
- jinja2 update (security) 2.10 => 2.10.1
- don't launch mflog2mfadmin is admin hostname is null
- more reliable checks about some circus watchers
- upgrade mflog to fix metwork-framework/mflog#8
- only the layers corresponding to the current addon should be in the
- fix the making of circus.ini from template on mfadmin (mfadmin.start was not working anymore)





