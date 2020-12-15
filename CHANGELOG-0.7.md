# release_0.7 CHANGELOG





## [Unreleased]







### New Features


- add hmac openresty component
- introduce components utility
- update mfutil_c and introduce mfutil_lua
- mflog update to support non standard logging levels
- add revert_ldd.sh and external_dependencies.sh utilities
- nodejs/npm update (nodejs 8.11.2 => 10.16.0, npm/6.1.0 => npm/6.9.0)
- telegraf update (1.10.2 => 1.11.2)
- upgrade redis from 3 to 5
- give up modules start if precondition failed
- upgrade python3 from 3.5.6 to 3.7.3, python2 from 2.7.15 to 2.7.16 and all python requirements with use of libressl instead of openssl
- update cookiecutter_hooks (reduce multi blank lines to a single one and conform python code to pep8)
- use envtpl new option --reduce-multi-blank-lines
- upgrade envtpl (both in python requirements and under portable_envtpl devtool)
- preserve some extra env var in mfxxx_wrapper







### Bug Fixes


- external_plugins/ directory for mfbase
- use vi in python2 mode when we are in python2
- fix vi usage without devtools
- plugin_env issue with python2 plugins
- disable SSE4.2 optimizations to avoid nginx crashing on old servers
- add pycodestyle (missing dependency for autopep8)
- add pycodestyle (missing dependency for autopep8)
- fix vim/vimdiff wrappers usage with git
- fix vimdiff wrapper
- close mflog issue11







## v0.7.2 (2019-08-06)







### New Features


- mflog update to support non standard logging levels







### Bug Fixes


- plugin_env issue with python2 plugins







## v0.7.1 (2019-06-27)







### New Features


- give up modules start if precondition failed







### Bug Fixes


- disable SSE4.2 optimizations to avoid nginx crashing on old servers







## v0.7.0 (2019-05-29)







### New Features


- preserve some extra env var in mfxxx_wrapper
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


- fix vimdiff wrapper
- fix vim/vimdiff wrappers usage with git
- close mflog issue11
- better vim wrappers (specially in plugin_env)
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






