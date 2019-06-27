# release_0.7 CHANGELOG


## [Unreleased]

### New Features
- give up modules start if precondition failed


### Bug Fixes
- disable SSE4.2 optimizations to avoid nginx crashing on old servers





## v0.7.0 (2019-05-29)

### New Features
- try to keep a backup of user files during uninstall
- split old scientific layer between scientific_core layer
- introduce mflog2mfadmin feature
- mflog update
- telegraf update
- update mflog and use new automatic context function
- remove prerequirements files
- update mflog
- add graphviz in devtools layer (for documentation)
- allow to build mfext behing a corporate http proxy
- urllib3 update (1.23 => 1.24.2) because of upstream security issue
- add search_paths feature to cookiecutter
- add cookiecutter_hooks project
- update openjdk 11.0.1 => 11.0.2 and add mirror
- openresty update (1.11.2.2 => 1.13.6.2)
- keep request_id field in logs
- add sqlite3 and libspatialite supports to gdal
- add werkzeug component (python wsgi toolbox)
- add some sysctl tunings
- add terminaltables component
- restore env after exiting plugin_env
- add libev component
- preserve some extra env var in mfxxx_wrapper


### Bug Fixes
- fix the making of circus.ini from template on mfadmin (mfadmin.start was not working anymore)
- only the layers corresponding to the current addon should be in the
- upgrade mflog to fix metwork-framework/mflog#8
- more reliable checks about some circus watchers
- don't launch mflog2mfadmin is admin hostname is null
- jinja2 update (security) 2.10 => 2.10.1
- fix building issues with proxy
- update internal circus version to fix a bug with async_kill feature
- use python3 to build glib2 python tools and remove references to python scl in these tools
- add a patch for openresty about nginx upstreams
- fix bug CHANGELOGS not generated when CHANGELOGS.md doesn't exist (for the first time)
- obsoletes removed python layer
- better vim wrappers (specially in plugin_env)
- close mflog issue11
- fix vim/vimdiff wrappers usage with git
- fix vimdiff wrapper





