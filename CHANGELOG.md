# CHANGELOG


## [Unreleased]

### New Features
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
- plugin_env issue with python2 plugins
- disable SSE4.2 optimizations to avoid nginx crashing on old servers
- add pycodestyle (missing dependency for autopep8)
- add pycodestyle (missing dependency for autopep8)
- fix vim/vimdiff wrappers usage with git
- fix vimdiff wrapper
- close mflog issue11





