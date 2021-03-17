include ../../../adm/root.mk
include ../../package.mk

export NAME=wheel
export VERSION=0.33.4
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=5bad0479ddf8d4dbfad212724a7b1f71
DESCRIPTION=\
A built-package format for Python.
WEBSITE=https://github.com/pypa/wheel
LICENSE=MIT

all:: $(PREFIX)/bin/wheel
$(PREFIX)/bin/wheel:
	$(MAKE) --file=../../Makefile.standard download uncompress python3build python3install
