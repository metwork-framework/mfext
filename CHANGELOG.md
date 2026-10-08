# CHANGELOG

## [Unreleased]

### New Features

- bump GitPython from 3.1.58 to 3.1.62 (fix critical and high CVE)
- bump pydantic from 2.13.4 to 2.13.5
- bump wrapt from 2.3.0 to 2.4.1
- bump hiredis from 1.2.0 to 1.2.1 (security fix)
- bump hiredis from 1.2.1 to 1.4.1 (#2937)
- bump hiredis python from 3.1.0 to 3.4.1 (compat. Python 3.15)
- bump libcst from 1.8.6 to 1.9.0 (compat. Python 3.15) (#2942)
- remove bump-pydantic (archived and not useful anymore) (#2943)
- bump cachetools from 7.1.7 to 7.1.8 (#2944)
- bump soupsieve from 2.8.4 to 2.9.2 (fix 2 moderate CVEs) (#2948)
- fix deprecated codecs in nginxfmt.py (mfserv.start)
- bump curl from 7.88.1 to 8.22.0 (fix critical CVE-2026-19931) (#2953)
- bump anyio from 4.9.0 to 4.15.1 (fix critical CVE-2026-63374) (#2955)
- bump openssl from 3.6.4 to 3.6.5 (fix high CVE-2026-84782) (#2956)
- revert "bump hdf4 from 4.3.1 to 4.4.0" (#2959)
- bump urllib3 from 2.7.0 to 2.8.0 (fix moderate CVE-2026-97688) (#2961)
- bump Werkzeug from 3.1.6 to 3.1.9 (fix moderate CVE-2026-102598) (#2962)
- bump tornado from 6.5.8 to 6.5.10 (fix high GHSA-c2m8-h5v5-343r) (#2963)
- bump fsspec from 2025.3.0 to 2026.9.0 (fix high CVE-2026-104851) (#2968)
- bump virtualenv from 21.7.8 to 21.7.16 (fix 3 high CVE) (#2970)
- bump virtualenv from 21.7.16 to 21.14.5 (#2972)
- bump Mako from 1.3.12 to 1.4.3 (fix moderate CVE-2026-102991) (#2973)

### Bug Fixes

- do not exclude packages from pip freeze (such as packaging) (#2928)
- remove deprecated codecs in nginxfmt.py (mfserv.start)


