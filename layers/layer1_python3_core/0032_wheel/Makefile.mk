include ../../../adm/root.mk
include ../../package_python3.mk

export NAME=wheel
export VERSION=0.37.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=e8450f7b882a99bd051b66c8bc18f31d
DESCRIPTION=\
A built-package format for Python.
WEBSITE=https://github.com/pypa/wheel
LICENSE=MIT

all:: $(PREFIX)/bin/wheel
$(PREFIX)/bin/wheel:
	$(MAKE) --file=../../Makefile.standard download uncompress python3build python3install_pip
