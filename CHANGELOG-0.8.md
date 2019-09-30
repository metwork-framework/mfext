# release_0.8 CHANGELOG



## v0.8.3 (2019-09-24)

### New Features
- add hmac openresty component






## v0.8.2 (2019-09-21)

### New Features
- introduce components utility


### Bug Fixes
- use vi in python2 mode when we are in python2





## v0.8.1 (2019-08-22)

### New Features


### Bug Fixes
- fix vi usage without devtools





## v0.8.0 (2019-08-19)

### New Features
- preserve some extra env var in mfxxx_wrapper
- upgrade envtpl (both in python requirements and under portable_envtpl devtool)
- use envtpl new option --reduce-multi-blank-lines
- update cookiecutter_hooks (reduce multi blank lines to a single one and conform python code to pep8)
- upgrade python3 from 3.5.6 to 3.7.3, python2 from 2.7.15 to 2.7.16 and all python requirements with use of libressl instead of openssl
- give up modules start if precondition failed
- upgrade redis from 3 to 5
- telegraf update (1.10.2 => 1.11.2)
- nodejs/npm update (nodejs 8.11.2 => 10.16.0, npm/6.1.0 => npm/6.9.0)
- add revert_ldd.sh and external_dependencies.sh utilities
- mflog update to support non standard logging levels
- update mfutil_c and introduce mfutil_lua


### Bug Fixes
- close mflog issue11
- fix vimdiff wrapper
- fix vim/vimdiff wrappers usage with git
- add pycodestyle (missing dependency for autopep8)
- add pycodestyle (missing dependency for autopep8)
- disable SSE4.2 optimizations to avoid nginx crashing on old servers
- plugin_env issue with python2 plugins





