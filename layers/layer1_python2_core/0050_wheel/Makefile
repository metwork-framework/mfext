include ../../../adm/root.mk
include ../../package.mk

export NAME=wheel
export VERSION=0.30.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=e48f8f2329f1419572d93b68a63272a9
DESCRIPTION=\
A built-package format for Python.
WEBSITE=https://github.com/pypa/wheel
LICENSE=MIT

all:: $(PREFIX)/bin/wheel
$(PREFIX)/bin/wheel:
	$(MAKE) --file=$(SRC_DIR)/layers/Makefile.standard download uncompress python2build python2install
