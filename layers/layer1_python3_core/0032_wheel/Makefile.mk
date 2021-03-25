include ../../../adm/root.mk
include ../../package.mk

export NAME=wheel
export VERSION=0.36.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=acf6ba4344efcec44bcab879c7e587d4
DESCRIPTION=\
A built-package format for Python.
WEBSITE=https://github.com/pypa/wheel
LICENSE=MIT

all:: $(PREFIX)/bin/wheel
$(PREFIX)/bin/wheel:
	$(MAKE) --file=../../Makefile.standard download uncompress python3build python3install_pip
