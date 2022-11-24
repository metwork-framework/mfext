include ../../../adm/root.mk
include ../../package_python3.mk

export NAME=wheel
export VERSION=0.38.4
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=4636ca5d5b8e1855d7f110300a769133
DESCRIPTION=\
A built-package format for Python.
WEBSITE=https://github.com/pypa/wheel
LICENSE=MIT

all:: $(PREFIX)/bin/wheel
$(PREFIX)/bin/wheel:
	$(MAKE) --file=../../Makefile.standard download uncompress python3build python3install_pip
